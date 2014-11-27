katoApp.controllers.controller('GridController',['$scope','meteor','uiGridConstants', ($scope, meteor, uiGridConstants)->

  meteor.autorun $scope, ->

    $scope.gridOptions =
      enableFiltering: true
      columnDefs: [
          name: '_id'
          displayName: '工号'
          field: '_id'
          cellTemplate: "<div class='ui-grid-cell-contents'><a ui-sref='app.employees.single'>[[COL_FIELD]]</a></div>"
          enableColumnMenu: false
          width: '15%'
          filter:
            condition: uiGridConstants.filter.CONTAINS
        ,
          name: 'name'
          displayName: '姓名'
          field: 'name'
          enableColumnMenu: false
          width: '15%'
          filter:
            condition: uiGridConstants.filter.CONTAINS
        ,
          name: 'groupId'
          displayName: '所属组'
          field: 'groupId'
          enableColumnMenu: false
          filter:
            condition: uiGridConstants.filter.CONTAINS
      ]

      data: People.find().fetch()

])
