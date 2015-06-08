angular.module('todoApp').controller 'SessionsCtrl', ['$scope', '$rootScope', '$state', 'List', 'Auth', 'toastr', 
  ($scope, $rootScope, $state, List, Auth, toastr) ->
    giveAccess = (user) ->
      $state.go 'home'
      $rootScope.todoLists = List.all()
      $rootScope.user = user

    $scope.logIn = () ->
      Auth.login({email: $scope.email, password: $scope.password}).then (user) ->
        giveAccess(user)
      , (error) ->
        toastr.error('You entered wrong data. Invalid email or password.', 'Error')

    $scope.signUp = () ->
      if $scope.password.length < 8
        toastr.error('Password too short. Must be at least 8 symbols.', 'Error')
        return
      if $scope.password != $scope.password_confirmation
        toastr.error('Password confirmation doesn\'t match password.', 'Error')
        return
      Auth.register({email: $scope.email, password: $scope.password, password_confirmation: $scope.password_confirmation}).then (user) ->
        giveAccess(user)
      , (error) ->   
        toastr.error('User with such email already exists!', 'Error')
]