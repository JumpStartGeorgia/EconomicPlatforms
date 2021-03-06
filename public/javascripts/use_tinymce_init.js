var class_added = false;

// copied from the examples directory for the jQuery version of tinyMCE
// $().ready(function() {
// 	$("textarea").tinymce({
// 		// Location of TinyMCE script
// 		script_url : '/javascripts/tinymce/jscripts/tiny_mce/tiny_mce.js',

// 		// apply class to all lists so they format correctly
// 	  onchange_callback : "tiny_mce_change",
// 	  init_instance_callback : "tiny_mce_init_instance",

// 		// General options
// 		theme : "advanced",
// 		plugins : "autolink,lists,table,fullscreen,advlist,paste",
// //		plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",

// 		// remove ugly MS word styling
// 		valid_styles : {'*' : 'color,font-weight,text-decoration'},

// 		// Theme options
// 	  theme_advanced_buttons1 : 'pasteword,|,bold, italic, underline, strikethrough,formatselect,|,bullist,numlist,|,image,|, link, unlink, undo, redo,|,fullscreen',
// 		theme_advanced_buttons2 : "tablecontrols",
// 		theme_advanced_buttons3 : "",
// 		theme_advanced_buttons4 : "",
// 		theme_advanced_toolbar_location : "top",
// 		theme_advanced_toolbar_align : "left",
// 		theme_advanced_statusbar_location : "bottom",
// 		theme_advanced_resizing : true,
// 		theme_advanced_blockformats : "p,h2,h3,h4",
// 		fix_list_elements : true


// 		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
// 		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
// 		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
// 		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
// 		theme_advanced_toolbar_location : "top",
// 		theme_advanced_toolbar_align : "left",
// 		theme_advanced_statusbar_location : "bottom",
// 		theme_advanced_resizing : true,

// 		// Example content CSS (should be your site CSS)
// 		content_css : "css/content.css",

// 		// Drop lists for link/image/media/template dialogs
// 		template_external_list_url : "lists/template_list.js",
// 		external_link_list_url : "lists/link_list.js",
// 		external_image_list_url : "lists/image_list.js",
// 		media_external_list_url : "lists/media_list.js",

// 		// Replace values for the template plugin
// 		template_replace_values : {
// 			username : "Some User",
// 			staffid : "991234"
// 		}

// 	});
// });

function tiny_mce_change (inst)
{
  tinyMCE.activeEditor.dom.addClass(tinyMCE.activeEditor.dom.select('ul'), 'standard');
  tinyMCE.activeEditor.dom.addClass(tinyMCE.activeEditor.dom.select('ol'), 'standard');

  var body = $(tinyMCE.activeEditor.dom.select('body')[0]);
  var div = body.find('div');
  var pre = body.find('pre');
  div.replaceWith(function (){ '<p>' + $(this).html() + '</p>' });
  pre.replaceWith(function (){ '<p>' + $(this).html() + '</p>' });
}

function tiny_mce_init_instance (inst)
{
  inst.dom.addClass(inst.dom.select('ul'), 'standard');
  inst.dom.addClass(inst.dom.select('ol'), 'standard');

  var body = $(inst.dom.select('body')[0]);
  var div = body.find('div');
  var pre = body.find('pre');
  div.replaceWith(function (){ '<p>' + $(this).html() + '</p>' });
  pre.replaceWith(function (){ '<p>' + $(this).html() + '</p>' });
}
