kitana = require 'kitana'

class window.Kitana.App
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
      @workspace.set_path this.value

$(document).ready ->
  window.app = new Kitana.App
