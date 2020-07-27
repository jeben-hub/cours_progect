import consumer from "./consumer"
var url = $(location).attr('href').split('/');
var id = url[url.length - 1];
if (url[url.length - 2] == "fanfics" &&
 Math.floor(id) == id && $.isNumeric(id))
{
  consumer.subscriptions.create({
      channel: "CommentsChannel",
      fanfic_id: id
    }, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      $('#msg').prepend('<div class="message"> ' +
      '<h3>' + data.user_name + '</h3>' +
      '<small>' + data.datetime  + '</small>' +
      '<p>' + data.content + '</p>' +
      '</div>')
     }
  });
}
