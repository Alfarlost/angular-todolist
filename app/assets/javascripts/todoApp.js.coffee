todoApp = angular.module('todoApp', ['ui.router', 'ui.bootstrap', 'templates'])

todoApp.controller 'MainCtrl', [
  '$scope'
  'todoLists'
  ($scope, todoLists) ->
    $scope.test = 'Hello world!'
    $scope.todoLists = todoLists.getAll()
    $scope.addList = ->
      todoLists.create({title: $scope.newList})
      $scope.newList = ''
]

todoApp.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: "testpage.html"
      controller: 'MainCtrl'
    $urlRouterProvider.otherwise '/home'
]

todoApp.factory 'todoLists', [
 '$http'
 ($http) ->
    t = todoLists: []

    t.getAll = ->
      $http.get('/todo_lists.json').success (data) ->
        angular.copy data, t.todoLists
        return

    t.create = ->
        $http.post('/todo_lists.json', todoList).success (data) ->
          t.todoLists.push data
]