theApp.controller 'rootController', ['$scope', 'meteor', ($scope, meteor)->

  meteor.autorun $scope, ->
    items = Items.find({})
    meteor.bind $scope, items, 'items'

]