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

window.updateJoggingTime = function ($el, data) {
  var parentLi = $el.parents('li');
  var joggingTimeId = parentLi.data('id');
  parentLi.replaceWith(data);
  var liSelector = 'li[data-id="' + joggingTimeId + '"]';
  pushNewJoggingTime($(liSelector));
};

onPageLoad('.filter-jogging-times', function ($el) {
  $el.find('button').click(function (e) {
    e.preventDefault();

    var $list = $('.jogging-times-list'),
        url = $list.data('load-more'),
        loadMoreCallback = $list.data('load-more-callback');

    var fromDate = $el.find('input[name="from_date"]').val(),
        toDate = $el.find('input[name="to_date"]').val();
    url += '?pagination=true';
    var queryString = '&from_date=' + fromDate;
    queryString += '&to_date=' + toDate;
    url += queryString;
    $.ajax({
      url: url,
      success: function (data) {
        $list.empty();
        $list.data('query-string', queryString);
        if(data !== ''){
          window[loadMoreCallback](data);
        }
      }
    });
  });
});