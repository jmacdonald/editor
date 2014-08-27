gulp = require 'gulp'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
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
          .on 'error', (err) ->
            console.log "#{event.path} compilation failed.
              Line #{err.location.first_line}: #{err.name} #{err.message}"
        .pipe gulp.dest path.dirname event.path

      console.log "Compiling #{event.path}..."

  gulp.watch 'css/**/*.sass', (event) ->
    if event.type == 'deleted'
      compiled_file = "#{event.path[..-5]}css"

      fs.unlink compiled_file, ->
        console.log "#{compiled_file} deleted."
    else
      gulp.src event.path
        .pipe sass errLogToConsole: true, sourceComments: 'normal'
        .pipe gulp.dest path.dirname event.path

      console.log "Compiling #{event.path}..."
