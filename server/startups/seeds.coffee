chance = new Chance()

one =
  day: (num=1, unit="y")->
    s = moment().subtract(num, unit).unix()
    e = moment().add(num, unit).unix()
    return moment.unix(_.random(s,e)).valueOf()

  pastDay: (num=1, unit="y")->
    s = moment().subtract(num, unit).unix()
    e = moment().unix()
    return moment.unix(_.random(s,e)).valueOf()


  person: ->
    _.sample(People.find().fetch())

  title: ->
    chance.sentence({words: _.random(3,6)}).slice(0,-1) #remove last dot

  name: ->
    chance.sentence({words: _.random(2,4)}).slice(0,-1) #remove last dot


some =
  people: (min=5, max=10)->
    allIds = _.map(People.find().fetch(), (obj)->obj._id)
    _.sample(allIds, _.random(min,max))



generateUsers = ->
  console.log "  Generating a users ..."

  name = chance.name()
  username = name.split(/[ -]/).join("_").toLowerCase()
  email = username + "@" + chance.domain()

  Accounts.createUser
    email: email
    username: username
    password: "123456"
    profile:
      name: name

generateGroups = ->

  console.log "  Generating groups ..."

  level = 3
  @groupIds = [null]

  _(level).times ->

    count = _.random(2,4)

    currentLevelGroupIds = []

    _.each @groupIds, (id)->
      _(count).times ->
        currentLevelGroupIds.push Groups.insert
          name: one.name()
          parentGroupId: id

    @groupIds = _.clone(currentLevelGroupIds)


generatePeople = ->

  console.log "  Generating people ..."

  _(500).times (index)->
    name = chance.name() + " (#{index})"

    People.insert
      name: "U-#{index}"
      groupId: _.sample(@groupIds)



generateProjects = ->

  console.log "  Generating projects ..."
  _(60).times ->
   
    startAt = one.pastDay()
    endAt = moment(startAt).add(_.random(20, 500), 'd').valueOf()

    Projects.insert
      name: one.name()
      startAt: startAt
      endAt: endAt
      groupId: _.sample(@groupIds)
      receivedWorkforces: []


generateWorkinfos = ->
  console.log "  Generating workinfos ..."      

  projects = Projects.find({}).fetch()

  _.each projects, (project)->

    members = some.people(4, 20)

    fullwork = _.random(Math.round(members.length / 4), Math.round(members.length / 2))
    halfwork = _.random(0, Math.round(members.length / 8))

    projectDays = moment.duration(project.endAt - project.startAt).asDays()

    _.each _.range(0, fullwork), (index)->
      Workinfos.insert
        projectId: project._id
        startAt: project.startAt
        endAt: project.endAt
        workforce: 100
        userId: members[index]

    _.each _.range(fullwork, fullwork + halfwork), (index)->
      Workinfos.insert
        projectId: project._id
        startAt: moment(project.startAt).add(_.random(1, projectDays/2), 'd').valueOf()
        endAt: moment(project.endAt).subtract(_.random(1, projectDays/2), 'd').valueOf()
        workforce: 50
        userId: members[index]

    _.each _.range(fullwork + halfwork, members.length), (index)->
      Workinfos.insert
        projectId: project._id
        startAt: moment(project.startAt).add(_.random(1, projectDays/2), 'd').valueOf()
        endAt: moment(project.endAt).subtract(_.random(1, projectDays/2), 'd').valueOf()
        workforce: 100
        userId: members[index]

generateReceivedWorkforces = ->

  console.log "  Generating receivedWorkforces ..."      
  projects = Projects.find({}).fetch()

  _.each projects, (project)->

    startYear = moment(project.startAt).year()
    endYear = moment(project.endAt).year()

    startMonth = moment(project.startAt).month()
    endMonth = moment(project.endAt).month()

    yearRange = _.range(startYear, endYear + 1)

    _.each yearRange, (year)->

      monthRangeStart = if year == startYear then startMonth else 1
      monthRangeEnd = if year == endYear then endMonth + 1 else 13

      monthRange = _.range(monthRangeStart, monthRangeEnd)

      _.each monthRange, (month)->

        m = moment({year: year, month: month - 1, day: 1})
        start = m.valueOf()
        end = m.endOf("month").valueOf()

        allworks = Workinfos.find(
          projectId: project._id
          startAt:
            $lte: end
          endAt:
            $gte: start
        ).fetch()

        totalDays = _.reduce(allworks, (memo, workinfo)->
          from = Math.max(workinfo.startAt, start)
          to = Math.min(workinfo.endAt, end)
          return memo + moment.duration(to - from).asDays()
        , 0)


        totalMonth = Math.round(totalDays / _.random(25, 35))

        monthString = moment(start).format("YYYYMM")

        Projects.update project._id, 
          $push:
            receivedWorkforces:
              month: monthString
              workforce: totalMonth



#if process.env.RESET_DB == 'true'
if Meteor.users.find().count() == 0 or process.env.RESETDB=='true'

  console.log "No users found. Reset database and generate some test data ..."

  Meteor.users.remove({})
  Groups.remove({})
  People.remove({})
  Projects.remove({})
  Workinfos.remove({})

  generateUsers()
  generateGroups()
  generatePeople()
  generateProjects()
  generateWorkinfos()
  generateReceivedWorkforces()
