
tinyMCE.init({
/*
  mode : "specific_textareas",
  editor_selector : "mceEditor",
*/
  mode : 'textareas',
  theme : "advanced",
  onchange_callback : "tiny_mce_change",

  theme_advanced_buttons1 : 'bold, italic, underline, strikethrough, bullist, numlist, link, unlink, cleanup, undo, redo'
});


function tiny_mce_change (inst)
{
/*
  html = inst.getBody().innerHTML;
  html = html.replace(/<ul>/gi, '<ul class="standard">');
  inst.getBody().innerHTML = html.replace(/<ol>/gi, '<ol class="standard">');
*/
  tinyMCE.activeEditor.dom.addClass(tinyMCE.activeEditor.dom.select('ul'), 'standard');
  tinyMCE.activeEditor.dom.addClass(tinyMCE.activeEditor.dom.select('ol'), 'standard');
}
