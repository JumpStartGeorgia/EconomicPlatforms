$('a#party_chart_selections_submit').click(function(){
	// append ec cat and ind cat ids to url
	url = $(this).attr('href');
	ec_id = $('select#economic_category_id').val();
	ind_id = $('select#indicator_category_id').val();

	url = url + "?economic_category_id=" + ec_id + "&indicator_category_id=" + ind_id;
	$(this).attr("href", url);
});
