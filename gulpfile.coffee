gulp = require 'gulp'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
fs = require 'fs'
path_lib = require 'path'

gulp.task 'default', ->
  coffee_path = 'js/*.coffee'
  sass_path = 'css/*.sass'

  # Do an initial compile of all assets.
  compile_coffee coffee_path
  compile_sass sass_path

  # Watch both directories for changes.
  gulp.watch coffee_path, (event) ->
    if event.type == 'deleted'
      compiled_file = "#{event.path[..-7]}js"

      fs.unlink compiled_file, ->
        console.log "#{compiled_file} deleted."
    else
      compile_coffee event.path

  gulp.watch sass_path, (event) ->
    if event.type == 'deleted'
      compiled_file = "#{event.path[..-5]}css"

      fs.unlink compiled_file, ->
        console.log "#{compiled_file} deleted."
    else
      compile_sass event.path

# Helper functions for compiling assets.
compile_coffee = (path) ->
  console.log "coffee invoked with #{path}"
  gulp.src path
    .pipe coffee()
      .on 'error', (err) ->
        console.log "#{path} compilation failed.
          Line #{err.location.first_line}: #{err.name} #{err.message}"
    .pipe gulp.dest path_lib.dirname path

  console.log "Compiling #{path}..."

compile_sass = (path) ->
  console.log "sass invoked with #{path}"
  gulp.src path
    .pipe sass errLogToConsole: true, sourceComments: 'normal'
    .pipe gulp.dest path_lib.dirname path

  console.log "Compiling #{path}..."
