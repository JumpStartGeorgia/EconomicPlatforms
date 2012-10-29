// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require i18n
//= require i18n/translations
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require jquery_nested_form
//= require vendor
//= require_tree .

// set focus to 3rd input field on page (first two are for search box)
$(document).ready(function(){
	if (gon.highlight_first_form_field){
	  $(":input:visible:enabled").eq(2).focus();
	}
});

$(function ()
{

  $('li.party-dropdown a').click(function ()
  {
    var c = $(this).siblings('ul.parties-dropdown');
    $('ul.parties-dropdown').not(c).hide(0);
    c.toggle(0);
    return false;
  });

});
