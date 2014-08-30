kitana = require 'kitana'
path = require 'path'

describe 'FileFinder', ->
  beforeEach ->
    initial_path = path.resolve './spec/dummy'
    this.app = { workspace: new kitana.Workspace(null, path.resolve initial_path) }

    this.file_finder = new kitana.FileFinder this.app
    this.file_finder.rebuild_index()

  describe 'rebuild_index', ->
    it 'populates @index with the correct values', ->
      expect(this.file_finder.index).toEqual ['directory/file', 'file']

    it 'runs whenever the app path changes', ->
      # Change the workspace path.
      this.app.workspace.set_path path.resolve './spec/dummy/directory'

      expect(this.file_finder.index).toEqual ['file']
