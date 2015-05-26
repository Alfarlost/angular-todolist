angular.module('todoApp').controller 'SessionsCtrl', ['$scope', '$state', 'Auth', ($scope, $state, Auth) ->
  $scope.logIn = () ->
    Auth.login({email: $scope.email, password: $scope.password}).then () ->
      $state.go 'home'

  $scope.signUp = () ->
    Auth.register({email: $scope.email, password: $scope.password, password_confirmation: $scope.password_confirmation}).then () ->
      $state.go 'home'
]