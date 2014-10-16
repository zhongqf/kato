chance = new Chance()

one =
  day: (num=1, unit="y")->
    s = moment().subtract(num, unit).unix()
    e = moment().add(num, unit).unix()
    return moment.unix(_.random(s,e)).valueOf()

  person: ->
    _.sample(Meteor.users.find().fetch())

  title: ->
    chance.sentence({words: _.random(3,6)}).slice(0,-1) #remove last dot

  sentence: ->
    chance.sentence({words: _.random(2,20)})

  paragraph: ->
    chance.paragraph({sentences: _.random(2,6)})


some =
  people: (min=5, max=10)->
    allIds = _.map(Meteor.users.find().fetch(), (obj)->obj._id)
    _.sample(allIds, _.random(min,max))

generateUsers = ->
  console.log "  Generating users ..."
  _(10).times (index)->
    name = chance.name()
    username = name.split(/[ -]/).join("_").toLowerCase()
    email = username + "@" + chance.domain()

    Accounts.createUser
      email: email
      username: username
      password: "123456"
      profile:
        name: name
        joinedAt: _.now()
        avatar:
          thumb_url: "/images/avatar/avatar#{index+1}.jpg"

generateItems = ->
  console.log "  Generating items ..."
  _(20).times (index)->
    Items.insert
      title: one.title()
      userId: one.person()
      createdAt: one.day()


#if process.env.RESET_DB == 'true'
if Meteor.users.find().count() == 0 or process.env.RESETDB=='true'

  console.log "No users found. Reset database and generate some test data ..."

  Meteor.users.remove({})
  Items.remove({})

  generateUsers()
  generateItems()
