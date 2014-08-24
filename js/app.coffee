class window.App
  constructor: ->
    @editor = new App.Editor
    @path_field = $('input#path')
    @_set_up_path_field()

  change_path: ->
    @path_field.trigger 'click'

  _set_up_path_field: ->
    @path_field.change ->
      @path = this.value

$(document).ready ->
  window.app = new App
