angular.module('todoApp').config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: "todos.html"
      controller: 'MainCtrl'
    $urlRouterProvider.otherwise '/home'
]