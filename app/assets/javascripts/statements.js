$(document).ready(function(){

	if(gon.edit_statement){
		// load the date time pickers
		$('#statement_date_made').datepicker({
				dateFormat: 'dd.mm.yy',
		});


		if (gon.date_made !== undefined &&
				gon.date_made.length > 0)
		{
			$("#statement_date_made").datepicker("setDate", new Date(gon.date_made));
		}
	}
});

