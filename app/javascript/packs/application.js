// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("jquery")
require("easy-autocomplete")
require("jquery-jeditable")
require("@nathanvda/on_the_spot")
import 'bootstrap'
import "packs/tags"
import "packs/rater"
import "packs/rating"
import Sortable from 'sortablejs';

//= require dropzone
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

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
