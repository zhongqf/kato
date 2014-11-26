angular.module('app.filters', [])
.filter('as_trusted', ['$sce', ($sce)->
  (text)-> $sce.trustAsHtml(text)
])
