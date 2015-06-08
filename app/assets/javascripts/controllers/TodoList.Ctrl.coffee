angular.module('todoApp').controller 'TodoListCtrl', [
  '$scope'
  '$rootScope'
  'List'
  ($scope, $rootScope, List) -> 
    $scope.addList = ->
      List.create {title: 'New Todo List'}, 
        (response) ->
          $rootScope.todoLists.unshift response
          $rootScope.todoLists[0]['showEdit'] = true

    $scope.delList = (todoList) ->
      List.destroy {id: todoList.id},
        (response) ->
          $rootScope.todoLists.splice($rootScope.todoLists.indexOf(todoList), 1)

    $scope.changeTodoTitle = (todoList) ->
      unless todoList.title == todoList.newTitle || !todoList.newTitle || todoList.newTitle == ''
        todoList.title = todoList.newTitle
        List.update {id: todoList.id, title: todoList.title}
]