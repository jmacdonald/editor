$(document).ready(function() {
  var myCodeMirror = CodeMirror($('#editor')[0], {
    value: 'function myScript(){return 100;}\n',
    mode:  'ruby',
    theme: 'monokai',
    vimMode: true
  });
});
