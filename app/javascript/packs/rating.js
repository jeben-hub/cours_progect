document.addEventListener("turbolinks:load", function() {
    var options = {
        max_value: 5,
        step_size: 1,
        initial_value: 0,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: $(".rating").attr("read-only"),
        change_once: false, // Determines if the rating can only be set once
        ajax_method: 'POST',
        url: '/new_rating',
        additional_data: { fanfic_id: $(".rating").attr("fanfic-id")} // Additional data to send to the server
    }

    $(".rating").rate(options);
});
