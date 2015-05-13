todoApp = angular.module('todoApp', ['templates', 'ui.router', 'ngResource', 'ui.sortable', 'mk.editablespan', 'ui.date', 'ui.bootstrap'])

$(document).tooltip({ selector: "[title]", trigger: 'focus', placement: 'bottom' })

$.datepicker.parseDate( "yy-mm-dd", "2007-01-26" )

todoApp.controller 'MainCtrl', [
  '$scope'
  '$timeout'
  'List'
  'Task'
  'Comment'
  ($scope, $timeout, List, Task, Comment) ->
    $scope.todoLists = List.all()

    $scope.addList = ->
      if !$scope.newList || $scope.newList == ''
        return 
      List.create {title: $scope.newList}, 
        (response) ->
          $scope.todoLists.unshift response
      $scope.newList = ''

    $scope.delList = (todoList) ->
      List.destroy {id: todoList.id},
        (response) ->
          $scope.todoLists.splice($scope.todoLists.indexOf(todoList), 1)

    $scope.addTask = (todoList, task) ->
      if !todoList.newTask || todoList.newTask == ''
        return 
      Task.create {todo_list_id: todoList.id, description: todoList.newTask},
        (response) ->
          unless todoList.tasks
            todoList['tasks'] = new Array
          todoList.tasks.unshift response
      todoList.newTask = ''

    $scope.delTask = (todoList, task) ->
      Task.destroy {id: task.id, todo_list_id: todoList.id},
        (response) ->
          todoList.tasks.splice todoList.tasks.indexOf(task), 1

    $scope.changeTodoTitle = (todoList) ->
      unless todoList.title == todoList.newTitle
        todoList.title = todoList.newTitle
        List.update {id: todoList.id, title: todoList.title}
    
    $scope.changeTaskDescription = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, description: task.description}
    
    $scope.completeTask = (task) ->
      Task.update { todo_list_id: task.todo_list_id, id: task.id, completed: task.completed }

    $scope.priorityChanged = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, priority: task.priority}

    $scope.changeDeadline = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, deadline: task.deadline}

    $scope.addComment = (task) ->
      if !task.newComment || task.newComment == ''
        return 
      Comment.create {todo_list_id: task.todo_list_id, task_id: task.id, body: task.newComment},
        (response) ->
          unless task.comments
            task['comments'] = new Array
          task.comments.unshift response
      task.newComment = ''

    updatePriorities = (currentTask, todoListIndex) ->
      $timeout ->
        angular.forEach $scope.todoLists[todoListIndex].tasks, (task, index) ->
          task.priority = index + 1
        $scope.priorityChanged(currentTask)

    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width $(this).width()
        return
      ui

    todoIndexFilter = (todoId) ->
      todoIndex = 0
      angular.forEach $scope.todoLists, (todo, index) ->
        if todo.id == todoId
          todoIndex = index
      return todoIndex

    $scope.dateOptions =
      showOn: 'button',
      buttonText: ''

    $scope.sortableOptions =
      containment: 'parent',
      cursor: 'move',
      tolerance: 'pointer',
      helper: fixHelper,
      update: 
        (e, ui) ->
          task = ui.item.scope().task
          updatePriorities(task, todoIndexFilter(task.todo_list_id))
   
]

todoApp.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: "todos.html"
      controller: 'MainCtrl'
    $urlRouterProvider.otherwise '/home'
]

todoApp.factory 'List', ($resource) ->
  $resource ('/api/todo_lists/:id'), { id: '@id' },
    create:
      method: 'POST'
    all:
      method: 'GET'
      isArray: true
    destroy:
      method: 'DELETE'
    update:
      method: 'PATCH'

todoApp.factory 'Task', ($resource) ->
  $resource ('/api/todo_lists/:todo_list_id/tasks/:id'), { todo_list_id: '@todo_list_id', id: '@id' },
    create:
      method: 'POST'
    destroy:
      method: 'DELETE'
    update:
      method: 'PATCH'

todoApp.factory 'Comment', ($resource) ->
  $resource ('/api/todo_lists/:todo_list_id/tasks/:task_id/comments/:id'), { todo_list_id: '@todo_list_id', task_id: '@task_id', id: '@id' },
    create:
      method: 'POST'
    destroy:
      method: 'DELETE'


todoApp.directive 'focusOn', ($timeout) ->
  {
    restrict: 'A'
    link: ($scope, $element, $attr) ->
      $scope.$watch $attr.focusOn, (_focusVal) ->
        $timeout ->
          if _focusVal then $element.focus()
  }

todoApp.directive 'ngEsc', ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which == 27
        scope.$apply ->
          scope.$eval attrs.ngEsc 
        event.preventDefault()

todoApp.directive 'ngEnter', ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which == 13
        scope.$apply ->
          scope.$eval attrs.ngEnter 
        event.preventDefault()





