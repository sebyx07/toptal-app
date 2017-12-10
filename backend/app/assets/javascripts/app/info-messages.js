onPageLoad('.info-messages', function ($el) {
  var $success = $el.find('.success');
  if($success.length > 0){
    toastr.success($success.text());
  }
});