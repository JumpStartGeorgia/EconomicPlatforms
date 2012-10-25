
function slider_auto ()
{
  activity.arrows[activity.direction_auto].click();

  activity.timer = setTimeout(slider_auto, activity.delay + activity.timeout);
}

$(function ()
{
  window.activity =
  {
    index: 0,
    timeout: 1000,
    delay: 3000,
    direction_auto: 'right',
    timer: null,
    arrows:
    {
      left : $('#activityslider .arrow[data-direction="left"]'),
      right: $('#activityslider .arrow[data-direction="right"]'),
    },
    slides: $('#activityslider .activities .each')
  };


  $('#activityslider').hover(
    function ()
    {
      clearTimeout(activity.timer);
    },
    function ()
    {
      activity.timer = setTimeout(slider_auto, activity.delay);
    }
  );

  activity.timer = setTimeout(slider_auto, activity.delay);


  if (typeof gon.slider_images != 'undefined' && gon.slider_images.length > 0)
  {
    var options =
    {
      width:         300,
      height:        180,
      element:       $('#activity_image_slider'),
      data:          gon.slider_images
    };

    var s1 = new Va_slider(options);
  }


});


$('#activityslider .arrow:not(.disabled)').live('click', function ()
{

  var direction = $(this).data('direction');

  var current = $('#activityslider .activities .each:visible');

  var next = (direction == 'left') ? -1 : 1;
  next = activity.index + next;

  // stop all animations
  activity.slides.stop(true, true);

  var overflow = 200;

  if (direction == 'left')
  {
    current.animate({top: overflow}, activity.timeout, function (){ $(this).hide(0).css('top', 0); });
    activity.slides.eq(next).css('top', -overflow).show(0).animate({top: 0}, activity.timeout);
  }
  else
  {
    current.animate({top: -overflow}, activity.timeout, function (){ $(this).hide(0).css('top', 0); });
    activity.slides.eq(next).css('top', overflow).show(0).animate({top: 0}, activity.timeout);
  }


  if (next > 0 && activity.arrows.left.hasClass('disabled'))
  {
    activity.arrows.left.removeClass('disabled');
  }

  if (next < (activity.slides.length - 1) && activity.arrows.right.hasClass('disabled'))
  {
    activity.arrows.right.removeClass('disabled');
  }

  if (next == 0)
  {
    activity.arrows.left.addClass('disabled');
    activity.direction_auto = 'right';
  }
  else if (next == (activity.slides.length - 1))
  {
    activity.arrows.right.addClass('disabled');
    activity.direction_auto = 'left';
  }

  activity.index = next;

});



$(document).ready(function ()
{

	if (gon.edit_activity)
	{
		// load the date time pickers
		$('#activity_date').datepicker({
				dateFormat: 'dd.mm.yy',
		});


		if (gon.activity_date !== undefined && gon.activity_date.length > 0)
		{
			$("#activity_date").datepicker("setDate", new Date(gon.date_made));
		}
	}
});

