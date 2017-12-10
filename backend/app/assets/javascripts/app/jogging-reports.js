window.generateJoggingTimeReport = function ($el, html) {
  var $joggingReports = $('.jogging-reports'),
      tbody = $joggingReports.find('tbody');
  tbody.empty();
  tbody.append(html);
};