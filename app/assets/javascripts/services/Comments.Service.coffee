angular.module('todoApp').factory 'Comment', ($resource) ->
  $resource ('/api/todo_lists/:todo_list_id/tasks/:task_id/comments/:id'), { todo_list_id: '@todo_list_id', task_id: '@task_id', id: '@id' },
    create:
      method: 'POST'
    destroy:
      method: 'DELETE'