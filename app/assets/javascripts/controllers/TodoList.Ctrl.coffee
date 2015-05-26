angular.module('todoApp').controller 'TodoListCtrl', [
  '$scope'
  '$rootScope'
  'List'
  ($scope, $rootScope, List) -> 
    $scope.addList = ->
      if !$scope.newList || $scope.newList == ''
        return 
      List.create {title: $scope.newList}, 
        (response) ->
          $rootScope.todoLists.unshift response
      $scope.newList = ''

    $scope.delList = (todoList) ->
      List.destroy {id: todoList.id},
        (response) ->
          $rootScope.todoLists.splice($rootScope.todoLists.indexOf(todoList), 1)

    $scope.changeTodoTitle = (todoList) ->
      unless todoList.title == todoList.newTitle
        todoList.title = todoList.newTitle
        List.update {id: todoList.id, title: todoList.title}
]