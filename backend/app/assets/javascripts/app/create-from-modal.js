window.createFromModal = function ($el) {
  var $modal = $el.parents('.modal');
  $modal.modal('close');
  $modal.find('input').each(function () {
    var $input = $(this);
    $input.val(undefined);
  });
};