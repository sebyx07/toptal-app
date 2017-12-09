onPageLoad('.datepicker', function ($el) {
  setDatePicker($el);
});

window.setDatePicker = function ($el) {
  $el.pickadate({
    selectMonths: true,
    selectYears: 15,
    today: 'Today',
    clear: 'Clear',
    closeOnSelect: false
  });
};

onPageLoad('.timepicker', function ($el) {
  setTimepicker($el);
});

window.setTimepicker = function ($el) {
  $el.pickatime({
    default: 'now',
    fromnow: 0,
    twelvehour: false,
    donetext: 'Ok',
    cleartext: 'Clear',
    canceltext: 'Cancel',
    autoclose: false,
    ampmclickable: true
  });
};