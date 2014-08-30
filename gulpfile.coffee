gulp = require 'gulp'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
fs = require 'fs'
path_lib = require 'path'
process = require 'child_process'
wd = require 'wd'

# Declare a variable to keep
# a reference to the browser.
browser = null

gulp.task 'default', ->
  coffee_paths = ['js/*.coffee', 'node_modules/kitana/*.coffee']
  sass_path = 'css/*.sass'

  # Fire up the selenium server so we can
  # control node-webkit remotely.
  selenium = process.spawn 'java', [
    '-jar'
    'selenium-server-standalone-2.42.2.jar'
    '-Dwebdriver.chrome.driver=./chromedriver'
  ]

  setTimeout ->
    # Initialize a connection to the browser
    # via selenium server using webdriver.
    browser = wd.remote()

    # Open a new node-webkit window.
    browser.init { browserName: 'chrome' }
  , 3000

  # Do an initial compile of all assets.
  compile_coffee coffee_paths
  compile_sass sass_path

  # Watch both directories for changes.
  gulp.watch coffee_paths, (event) ->
    refresh_app()

    if event.type == 'deleted'
      compiled_file = "#{event.path[..-7]}js"

      fs.unlink compiled_file, ->
        console.log "#{compiled_file} deleted."
    else
      compile_coffee event.path

  gulp.watch sass_path, (event) ->
    refresh_app()

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

refresh_app = ->
  # Refresh the browser.
  browser.close()
  browser.init { browserName: 'chrome' }
