$(function ()
{
  window.activity =
  {
    index: 0,
    arrows:
    {
      left : $('#activityslider .arrow[data-direction="left"]'),
      right: $('#activityslider .arrow[data-direction="right"]'),
    }
  }
});


$('#activityslider .arrow:not(.disabled)').live('click', function ()
{

  var direction = $(this).data('direction');

  var slides = $('#activityslider .activities .each'),
     current = $('#activityslider .activities .each:visible');

  var next = (direction == 'left') ? -1 : 1;
  next = activity.index + next;

  // stop all animations
  slides.stop(true, true);

  current.fadeOut();
  slides.eq(next).fadeIn();


  if (next > 0 && activity.arrows.left.hasClass('disabled'))
  {
    activity.arrows.left.removeClass('disabled');
  }

  if (next < (slides.length - 1) && activity.arrows.right.hasClass('disabled'))
  {
    activity.arrows.right.removeClass('disabled');
  }

  if (next == 0)
  {
    activity.arrows.left.addClass('disabled');
  }
  else if (next == (slides.length - 1))
  {
    activity.arrows.right.addClass('disabled');
  }

  activity.index = next;

});


