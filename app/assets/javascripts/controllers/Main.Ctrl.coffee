angular.module('todoApp').controller 'MainCtrl', [
  '$scope'
  '$state'
  '$rootScope'
  'Auth'
  ($scope, $state, $rootScope, Auth) ->
    $scope.logOut = () ->
      Auth.logout().then () ->
        $state.go 'login'
        $rootScope.user = null
]