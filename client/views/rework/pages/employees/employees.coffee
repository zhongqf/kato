katoApp.controllers.controller('GridController',['$scope','meteor', ($scope, meteor)->

  $scope.griddata = [
    ['HX0677','仲秦锋','PG-2','开发G','会计维持管理','12'],
    ['HX1234','关羽','PM-1','AMO','无印良品','23']
  ]

  $scope.data_options = 
    data: $scope.griddata
    language:
      url:'/l10n/dt_chinese.json'

])
