angular.module('todoApp').controller 'CommentCtrl', ['$scope', 'Comment', 'FileUploader', '$rootScope',
  ($scope, Comment, FileUploader, $rootScope) ->  
    
    $scope.uploader = new FileUploader( 
      url: 'file_storages' 
    )

    $scope.uploader.onCompleteItem = (fileItem, response, status, headers) ->
      $scope.task.comments.forEach (fileItem)->
        if fileItem.id == response.comment_id
          comment = item
          if comment.file_storage == undefined
            comment.file_storage = new Array(response)
          else
            comment.file_storage.push(response)
]
