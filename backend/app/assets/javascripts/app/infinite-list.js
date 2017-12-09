onPageLoad('.infinite-list', function ($el) {
  var currentPage = 1;
  var loadMoreUrl = $el.data('load-more');
  var loadMoreCallback = $el.data('load-more-callback');
  var loadMore = true;

  $el.scroll(function () {
    var percent = $el[0].scrollHeight * 0.1;
    if ($el[0].scrollHeight - $el.scrollTop() < $el.outerHeight() + percent && loadMore) {
      loadMore = false;
      var url = loadMoreUrl + '?pagination=true';
      var nextPage = currentPage + 1;
      url += '&page=' + nextPage;
      $.ajax({
        url: url,
        success: function (data) {
          if(data !== ''){
            window[loadMoreCallback](data);
            currentPage += 1;
            loadMore = true;
          }
        }
      })
    }
  });
});