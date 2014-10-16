tick = -> Session.set("time", new Date())
Meteor.setInterval tick, 1000

theApp.controller 'appController', ['$scope', ($scope)->
  $scope.config = 
    applicationName: 'Kato'

]