
###
fusionApp.config ['$routeProvider', ($rp)->
  $rp
  .when '/',
    templateUrl: 'layout',
    controller: 'RouteListCtl'
  .otherwise
      redirectTo: '/list'
]
###

theApp
  .config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider)->
  	
    $urlRouterProvider.otherwise("/404")

    $stateProvider
      .state 'root',
        url: '/'
        templateUrl: 'root'

      .state 'rework',
        url: '/rework'
        templateUrl: 'rework'
  ]
