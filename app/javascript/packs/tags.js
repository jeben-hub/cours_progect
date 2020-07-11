
document.addEventListener("turbolinks:load", function() {

  $input = $('#tags_field')

  var options = {
    url: function(phrase) {
      return "/tag_search.json?term=" + phrase.split(", ").slice(-1)[0];
    },
    getValue: "name",
  };

  $input.easyAutocomplete(options);

});
