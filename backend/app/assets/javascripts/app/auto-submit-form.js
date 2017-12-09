var saveForm = function ($el, cb) {
  var method = $el.find('input[name="_method"]').val() || 'post';
  var url = $el.attr('action');
  $.ajax({
    type: method,
    url: url,
    data: $el.serialize(),
    success: function(data)
    {
      var message = 'Saved!';
      if(data && data.message){
        message = data.message;
      }
      toastr.success(message);
      if(cb){
        cb(data);
      }
    },
    error: function (error) {
      toastr.error(error);
    }
  });
};

onPageLoad('form.auto-submit', function ($els) {
  autoSubmitForm($els);
});

window.autoSubmitForm = function ($els) {
  $els.each(function () {
    var $el = $(this);
    $el.submit(function (e) {
      e.preventDefault();
      saveForm($el);
    });

    var handleChange= function ($input) {
      var oldValue = $input.attr('value');
      if(oldValue === $input.val()){
        return true;
      }
      $input.attr('value', $input.val());
      saveForm($el);
    };

    $el.find('input').focusout(function () {
      handleChange($(this));
    });

    var $timePickers = $el.find('input.timepicker, input.datepicker');

    $timePickers.off('focusout');
    $timePickers.change(function () {
      handleChange($(this));
    });
  });
};

onPageLoad('.submittable-form', function ($el) {
  $el.submit(function (e) {
    e.preventDefault();
    var callback = $el.data('callback');
    saveForm($el, function (data) {
      if(callback){
        window[callback]($el, data);
      }
    });
  });
});