kitana = require 'kitana'
path = require 'path'
{EventEmitter} = require 'events'

describe 'FileFinder', ->
  beforeEach ->
    this.app = new EventEmitter
    this.app.path = path.resolve './spec/dummy'

    this.file_finder = new kitana.FileFinder this.app
    this.file_finder.rebuild_index()

  describe 'rebuild_index', ->
    it 'populates @index with the correct values', ->
      expect(this.file_finder.index).toEqual ['directory/file', 'file']

    it 'runs whenever the app path changes', ->
      # Change the app's path attribute.
      this.app.path = path.resolve './spec/dummy/directory'

      # Trigger the event to which the file finder should be subscribed.
      this.app.emit 'kitana.app.path_changed'

      expect(this.file_finder.index).toEqual ['file']
