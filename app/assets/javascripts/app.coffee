app = angular.module 'todoApp', ['templates', 'ui.router', 'ngResource', 'ui.sortable', 'mk.editablespan', 'ui.date', 'angularFileUpload']

$(document).tooltip({ selector: "[title]", trigger: 'focus', placement: 'bottom' })

$.datepicker.parseDate( "yy-mm-dd", "2007-01-26" )










