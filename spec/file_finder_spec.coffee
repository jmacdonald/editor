ff = require '../js/file_finder.coffee'
path = require 'path'

describe 'FileFinder', ->
  beforeEach ->
    this.file_finder = new ff.FileFinder { path: path.resolve './spec/dummy' }
    this.file_finder.rebuild_index()

  describe 'rebuild_index', ->
    it 'populates @index with the correct values', ->
      expect(this.file_finder.index).toEqual ['directory/file', 'file']
