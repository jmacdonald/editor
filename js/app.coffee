kitana = require 'kitana'
{EventEmitter} = require 'events'

class window.Kitana.App extends EventEmitter
  constructor: ->
    @editor = new Kitana.Editor
    @workspace = new kitana.Workspace @, process.cwd()
    @file_finder = new kitana.FileFinder @
    @path_field = $('input#path')
    @_set_up_path_field()

  change_path: ->
    @path_field.trigger 'click'

  _set_up_path_field: ->
    @path_field.change ->
      @path = this.value

      # Let any subscribers know that this value has changed.
      @.emit 'kitana.app.path_changed'

$(document).ready ->
  window.app = new Kitana.App
