angular.module('todoApp').directive 'ngEsc', ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which == 27
        scope.$apply ->
          scope.$eval attrs.ngEsc 
        event.preventDefault()