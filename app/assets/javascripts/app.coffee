app = angular.module 'todoApp', ['templates', 'ui.router', 'ngResource', 'Devise', 'ui.sortable', 'mk.editablespan', 'ui.date', 'angularFileUpload']

app.run ($rootScope, $state, $location, Auth, List) ->
  Auth.currentUser().then (user) ->
    $state.go 'home'
    $rootScope.todoLists = List.all()
  
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState) ->
    shouldLogIn = toState.data != undefined && toState.data.requireLogin && Auth._currentUser == null
    
    if shouldLogIn
      $state.go('login')

$.datepicker.parseDate( "yy-mm-dd", "2007-01-26" )










