angular.module('todoApp').controller 'CommentCtrl', ['$scope', 'Comment', 'FileUploader', '$rootScope',
  ($scope, Comment, FileUploader, $rootScope) ->
    $scope.addComment = (task) ->
      if !task.newComment || task.newComment == ''
        return 
      Comment.create {todo_list_id: task.todo_list_id, task_id: task.id, body: task.newComment},
        (response) ->
          unless task.comments
            task['comments'] = new Array
          task.comments.unshift response
      task.newComment = ''

    $scope.deleteComment = (task, comment) ->
      Comment.destroy {todo_list_id: task.todo_list_id, task_id: task.id, id: comment.id},
        (response) ->
          $scope.task.comments.splice($scope.task.comments.indexOf(comment), 1)
    
    $scope.uploader = new FileUploader( 
      url: 'file_storages' 
    )

    $scope.uploader.onBeforeUploadItem = (fileItem) ->
      fileItem.formData.push({file_name: fileItem.file.name})
      fileItem.remove()

    $scope.uploader.onCompleteItem = (fileItem, response, status, headers) ->
      $scope.task.comments.forEach (fileItem)->
        if fileItem.id == response.comment_id
          comment = fileItem
          if comment.file_storages == undefined
            comment.file_storages = new Array(response)
          else
            comment.file_storages.push(response)
]
