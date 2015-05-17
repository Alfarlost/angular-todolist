angular.module('todoApp').directive 'focusOn', ($timeout) ->
  {
    restrict: 'A'
    link: ($scope, $element, $attr) ->
      $scope.$watch $attr.focusOn, (_focusVal) ->
        $timeout ->
          if _focusVal then $element.focus()
  }