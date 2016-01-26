(function() {
var init = function() {
  var readerContainer = $("#reader-container");
  if(readerContainer.size() > 0) {
    var pusher = new Pusher('da03829d30f7142f7f34', { encrypted: true });
    var notificationsChannel = pusher.subscribe('notifications');

    notificationsChannel.bind('new_notification', function(notification){
        var message = notification.message;
        $('.word-container').html(message);
    });
  }
};

  $(document).ready(function() {
    init();
  });
})();

