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
import "packs/chapters_table"

//= require dropzone


document.addEventListener("turbolinks:load", function() {
  $("#themeSwitch").on("change", function(event){
     if ( $(this).prop("checked")) {
       $("body").attr("data-theme", "dark")
     } else {
       $("body").attr("data-theme", "light")
     }
     $.ajax({
       type: "GET",
       url: "/user_theme"
     });
  });
});
