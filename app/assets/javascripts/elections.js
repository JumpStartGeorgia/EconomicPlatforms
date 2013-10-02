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


  var field = $('#platform_election_id, #policy_brief_election_id, #statement_election_id');
  var replacefield = $('#platform_political_party_id, #policy_brief_political_party_id, #statement_political_party_id');
  if (field.length && replacefield)
  {
    field.change(function ()
    {
      replacefield.attr('disabled', 1);
      replacefield.load(gon.election_political_parties_path.replace(/[0-9]+(\/)?$/, field.val() + '$1'), function ()
      {
        replacefield.removeAttr('disabled');
      });
    });
  }



});

