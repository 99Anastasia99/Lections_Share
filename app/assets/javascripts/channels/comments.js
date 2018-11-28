App.comments = App.cable.subscriptions.create("CommentsChannel",
{
  received: function(data) {
    var comment_pane = $('#comment_pane');
    comment_pane.prepend(data['comment']);
    $('#comment_body').val('');
  }
});
