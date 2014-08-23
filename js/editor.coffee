class window.App.Editor
  constructor: ->
    @cm = CodeMirror(
      $('#editor')[0],
      {
        mode:  'ruby'
        theme: 'monokai'
        vimMode: true
        extraKeys:
          "'o'": (editor) ->
            window.App.file_handler.open()
      }
    )

    @cm.focus()
