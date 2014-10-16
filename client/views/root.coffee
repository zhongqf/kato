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

  meteor.autorun $scope, ->
    $scope.group = Groups.findOne Session.get("selectedGroupId")
    meteor.bind $scope, Projects.find({groupId: $scope.group?._id}), 'projects'

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

      workinfos = Workinfos.find(
        projectId: project._id
        startAt:
          $lte: month.endOf("month").valueOf()
        endAt:
          $gte: month.valueOf()
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

