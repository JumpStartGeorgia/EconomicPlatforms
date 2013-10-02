$(document).ready(function(){

	if(gon.edit_election){
		// load the date time pickers
		$('#election_date').datepicker({
				dateFormat: 'dd.mm.yy',
		});

  /*
		if (gon.election_date !== undefined &&
				gon.election_date.length > 0)
		{
			$("#election_date").datepicker("setDate", new Date(gon.election_date));
		}
	*/
	}
});

