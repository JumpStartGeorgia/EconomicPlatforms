
function slider_auto ()
{
  activity.arrows[activity.direction_auto].click();
  if (activity.index == 0)
  {
    activity.direction_auto = 'right';
  }
  else if (activity.index == (activity.slides.length - 1))
  {
    activity.direction_auto = 'left';
  }

  setTimeout(slider_auto, activity.delay + activity.timeout);
}

$(function ()
{
  window.activity =
  {
    index: 0,
    timeout: 1000,
    delay: 3000,
    direction_auto: 'right',
    arrows:
    {
      left : $('#activityslider .arrow[data-direction="left"]'),
      right: $('#activityslider .arrow[data-direction="right"]'),
    },
    slides: $('#activityslider .activities .each')
  };

  setTimeout(slider_auto, activity.delay);

});


$('#activityslider .arrow:not(.disabled)').live('click', function ()
{

  var direction = $(this).data('direction');

  var current = $('#activityslider .activities .each:visible');

  var next = (direction == 'left') ? -1 : 1;
  next = activity.index + next;

  // stop all animations
  activity.slides.stop(true, true);

  var overflow = 150;

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
  }
  else if (next == (activity.slides.length - 1))
  {
    activity.arrows.right.addClass('disabled');
  }

  activity.index = next;

});


