katoApp.controllers.controller('GridController',['$scope','meteor','ngTableParams', ($scope, meteor, ngTableParams)->

  data = []

  $scope.tableParams = new ngTableParams
      page: 1
      count: 10
    ,
      total: data.length
      getData: ($defer, params)->
        sliced_data = data.slice((params.page() - 1) *  params.count(), params.page() * params.count())
        $defer.resolve( sliced_data )
 
  meteor.autorun $scope, ->
    data = People.find().fetch()
    $scope.tableParams.reload()

])
