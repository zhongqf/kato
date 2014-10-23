theApp.controller 'rootGroupController', ['$scope', 'meteor', ($scope, meteor)->

  meteor.autorun $scope, ->
    childGroups = Groups.find({parentGroupId: null})
    meteor.bind $scope, childGroups, 'childGroups'

]

theApp.controller 'childGroupController', ['$scope', 'meteor', ($scope, meteor)->

  meteor.autorun $scope, ->
    group = $scope.$parent.group
    childGroups = Groups.find({parentGroupId: group._id})
    meteor.bind $scope, childGroups, 'childGroups'

  $scope.switchGroup = (group)->
    Session.set("selectedGroupId", group._id)
]

theApp.controller "groupController", ['$scope', 'meteor', ($scope, meteor)->

  findPosterityGroupIds = (id)->
    ids = _.map(Groups.find(ancestorGroupId: id).fetch(), (x)->x._id)
    ids.push(id)
    return ids

  meteor.autorun $scope, ->
    $scope.group = Groups.findOne Session.get("selectedGroupId")
    posterityGroupIds = findPosterityGroupIds($scope.group?._id) || []
    meteor.bind $scope, Projects.find({groupId: {$in: posterityGroupIds}}), 'projects'

]


theApp.controller "projectController", ['$scope', 'meteor', ($scope, meteor)->
  meteor.autorun $scope, ->
    project = $scope.$parent.project
    year = Session.get("viewYear") || 2014
    months = _.range(0,12)

    $scope.monthInfos = _.map months, (month)->

      month = moment({year: year, month: month, day: 1 })

      monthString = month.format("YYYYMM")
      monthTitle = month.format("YYYY/MM")

      receivedWorkforce = _.find project.receivedWorkforces, (s)-> s.month == monthString

      start = month.valueOf()
      end = month.endOf("month").valueOf()

      workinfos = Workinfos.find(
        projectId: project._id
        startAt:
          $lte: end
        endAt:
          $gte: start
      ).fetch()


      peopleNames = _.map(workinfos, (info)->
        return People.findOne(info.userId).name
      )

      return {
        title: monthTitle
        workforce: if receivedWorkforce then receivedWorkforce.workforce else ''
        peopleNames: peopleNames.join("<br>")
      }

]


theApp.filter('as_trusted', ['$sce', ($sce)->
  (text)-> $sce.trustAsHtml(text)
])

