angular.module('todoApp').config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: "todos.html"
      controller: 'MainCtrl'
      data:
        requireLogin : true
    $stateProvider.state 'login',
      url: '/log_in'
      templateUrl: "log_in.html"
      controller: 'SessionsCtrl'
    $stateProvider.state 'signup',
      url: '/sign_up'
      templateUrl: "sign_up.html"
      controller: 'SessionsCtrl'
    $urlRouterProvider.otherwise '/home'
]