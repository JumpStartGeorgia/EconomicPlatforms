$('a#category_chart_selections_submit').click(function(){
	// append pol party and ind cat ids to url
	url = $(this).attr('href');
	pp_id = $('select#political_party_id').val();
	ind_id = $('select#indicator_category_id').val();

	url = url + "?political_party_id=" + pp_id + "&indicator_category_id=" + ind_id;
	$(this).attr("href", url);
});
