window.newJoggingTime = function ($el, html) {
  var $html = $(html);
  $('.jogging-times-list').prepend($html);
  pushNewJoggingTime($html);
  createFromModal($el);
};

window.pushNewJoggingTime = function ($html) {
  turboOverride($html.find('a'));
  $html.find('label').each(function () {
    var $label = $(this);
    if($label.siblings('input').val()){
      $label.addClass('active');
    }
  });

  setDatePicker($html.find('.datepicker'));
  setTimepicker($html.find('.timepicker'));
  autoSubmitForm($html.find('form.auto-submit'));
};

window.loadMoreJoggingTimes = function (html) {
  var $html = $(html);
  $('.jogging-times-list').append($html);
  pushNewJoggingTime($html);
};