angular.module('todoApp').factory 'Task', ($resource) ->
  $resource ('/api/todo_lists/:todo_list_id/tasks/:id'), { todo_list_id: '@todo_list_id', id: '@id' },
    create:
      method: 'POST'
    destroy:
      method: 'DELETE'
    update:
      method: 'PATCH'