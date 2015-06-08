app = angular.module 'todoApp', ['templates', 'ui.router', 'ngResource', 'Devise', 'ui.sortable', 'ngAnimate', 'toastr', 'ui.date', 'angularFileUpload']

app.run ($rootScope, $state, $location, Auth, List) ->
  Auth.currentUser().then (user) ->
    $state.go 'home'
    $rootScope.todoLists = List.all()
    $rootScope.user = user
  ,(error) ->
    $state.go 'login'

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState) ->
    shouldLogIn = toState.data != undefined && toState.data.requireLogin && Auth._currentUser == null
    
    if shouldLogIn
      $state.go 'login'

app.config (toastrConfig) ->
  angular.extend toastrConfig, 
    positionClass: 'toast-bottom-right'
    timeOut: 8000

$.datepicker.parseDate( "yy-mm-dd", "2007-01-26" )








