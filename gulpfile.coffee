gulp = require 'gulp'
coffee = require 'gulp-coffee'
fs = require 'fs'
path = require 'path'

gulp.task 'default', ->
  gulp.watch 'js/**/*.coffee', (event) ->
    if event.type == 'deleted'
      compiled_file = "#{event.path[..-7]}js"

      fs.unlink compiled_file, ->
        console.log "#{compiled_file} deleted."
    else
      gulp.src event.path
        .pipe coffee()
        .pipe gulp.dest path.dirname event.path

      console.log "#{event.path} compiled."
