onPageLoad('.modal-trigger', function ($el) {
  var $modal = $('#' + $el.data('target'));
  $modal.modal();
});