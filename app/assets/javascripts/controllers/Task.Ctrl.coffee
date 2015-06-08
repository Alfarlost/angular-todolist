angular.module('todoApp').controller 'TaskCtrl', [
  '$scope'
  '$timeout'
  'Task'
  ($scope, $timeout, Task) ->

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
    
    $scope.changeTaskDescription = (task) ->
      unless task.description == task.newDescription || !task.newDescription || task.newDescription == ''
        task.description = task.newDescription
        Task.update {todo_list_id: task.todo_list_id, id: task.id, description: task.description}
    
    $scope.completeTask = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, completed: task.completed}

    $scope.priorityChange = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, priority: task.priority}

    $scope.changeDeadline = (task) ->
      Task.update {todo_list_id: task.todo_list_id, id: task.id, deadline: task.deadline}

    updatePriorities = (task) ->
      $timeout ->
        angular.forEach $scope.todoList.tasks, (task, index) ->
          task.priority = index + 1
        $scope.priorityChange(task)

    fixHelper = (e, ui) ->
      ui.css({'word-wrap':'break-word', 'max-width':'100%'})
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