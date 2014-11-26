
katoApp
  .config ['$stateProvider', '$urlRouterProvider', ($sp, $urp)->
  	
    $urp
      .otherwise("/404")
      .when('/employees', '/employees/')

    $sp
      .state 'app', 
        abstract: true
        templateUrl: 'app'
        data:
          authenticate: false

      .state 'app.kato', 
        url: '/kato'
        templateUrl: 'pages_kato'

      .state 'app.employees', 
        url: '/employees'
        views: 
          'page_header@app': 
            templateUrl: 'pages_employees_header'
          'page_tabs@app': 
            templateUrl: 'pages_employees_tabs'
      .state 'app.employees.home', 
        url: '/'
        views: 
          '@app': 
            templateUrl: 'pages_employees'
      .state 'app.employees.misc', 
        url: '/misc'
        views: 
          '@app': 
            templateUrl: 'pages_employees_misc'
      .state 'app.employees.single', 
        url: '/single'
        views : 
          'page_header@app': 
            templateUrl: 'pages_employees_single_header'
          'page_tabs@app': 
            templateUrl: 'pages_employees_single_tabs'
          '@app': 
            templateUrl: 'pages_employees_single'

      .state 'app.projects', 
        url: '/projects'
        templateUrl: "pages_projects"
  ]
  .run ['$rootScope', '$state', 'meteor', ($rs, $state, meteor)->

    meteor.autorun $rs, ->
      $rs.currentUser = Meteor.user()
      if not $rs.currentUser and $state.current.data?.authenticate
        $state.transitionTo('login')

    $rs.$on '$stateChangeStart', (event, toState, toStateParams, fromState, fromStateParams)->
      if toState.data?.authenticate and not Meteor.user()
        $state.transitionTo('login')
        event.preventDefault()
  ]
