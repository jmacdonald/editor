fs = require 'fs'

class window.App.FileHandler
  constructor: (@editor) ->
    @input_field = $('input#open_file')
    @_set_up_input_field()

  open: ->
    @input_field.trigger 'click'

  _set_up_input_field: ->
    @input_field.change ->
      fs.readFile this.value, 'utf8', (_, data) ->
        App.editor.cm.getDoc().setValue data
