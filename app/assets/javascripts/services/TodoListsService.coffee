angular.module('todoApp').factory 'List', ($resource) ->
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