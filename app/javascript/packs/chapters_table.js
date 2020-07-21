import Sortable from 'sortablejs';
document.addEventListener("turbolinks:load", function() {
  var el = document.getElementById('chapters-edit');
  var sortable = Sortable.create(el);
  $('#save-chapters-table').on('click', function() {
    var ids = $(el).children().map(function() {
      return $(this).attr("chapter-id");
    });
    $.ajax({
      type: "POST",
      url: "/chapters_sort?chapters_ids=" + Array.from(ids).join()
    });
  });
});
