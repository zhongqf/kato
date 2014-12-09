katoApp.controllers.controller('GridController',['$scope','meteor', ($scope, meteor)->

  $scope.itemsByPage = 15
  $scope.rowCollection = []

  $scope.personCollection = [].concat($scope.rowCollection);

  meteor.autorun $scope, ->
    $scope.rowCollection = People.find().fetch()

])
