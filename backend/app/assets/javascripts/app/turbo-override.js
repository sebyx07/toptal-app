onPageLoad('a[data-callback]', function ($els) {
  turboOverride($els);
});
window.turboOverride = function ($els) {
  $els.each(function () {
    var $el = $(this);

    var method = $el.data('method'),
        url = $el.attr('href'),
        callback = $el.data('callback'),
        message = $el.data('message');

    $el.click(function (e) {
      e.preventDefault();
      $.ajax({
        type: method,
        url: url,
        success: function() {
          window[callback]($(e.target));
          toastr.success(message);
        }
      });
    });
  });
};