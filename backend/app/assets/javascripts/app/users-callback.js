window.newUser = function ($el, html) {
  var $html = $(html);
  $('.users-list').prepend($html);
  pushNewUser($html);
  createFromModal($el);
};

window.pushNewUser = function ($html) {
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
  $html.find('select').material_select();
};

window.loadMoreUsers = function (html) {
  var $html = $(html);
  $('.users-list').append($html);
  pushNewUser($html);
};

window.updateUser = function ($el, data) {
  var parentLi = $el.parents('li');
  var userId = parentLi.data('id');
  parentLi.replaceWith(data);
  var liSelector = 'li[data-id="' + userId + '"]';
  pushNewUser($(liSelector));
};

