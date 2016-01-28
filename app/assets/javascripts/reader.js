(function() {
  var words;
  var interval;
  var pusherChannel;

  var init = function() {
    var readerContainer = $("#reader-container");
    pusherChannel = $("#notification-channel").attr('value');
    if(readerContainer.size() > 0 && pusherChannel.length > 0) {
      var pusher = new Pusher('da03829d30f7142f7f34', { encrypted: true });
      notificationsChannel = pusher.subscribe(pusherChannel);

      notificationsChannel.bind('new_notification', function(notification){
          var message = notification.message;
          $('.word-container').html(message);
      });
    }
    var text = $('.well-lg').text();
    words = text.split(/\s+/);
    $("#start-reading-button").on("click", playText);
    $("#glyphicon-pause-button").on("click", pauseText);
    $("#glyphicon-resume-button").on("click", resumeText);

    $(".dropdown-menu li a").click(function(){
      $(this).parents(".btn-group").find('.selection').text($(this).text());
      $(this).parents(".btn-group").find('.selection').attr("value", $(this).attr('value'));
    });
  };

  var playText = function () {
    $('#start-reading-button').attr('disabled','disabled');
    var wordsPerMin = parseInt($('.reading-speed .dropdown-toggle .selection').attr('value'));
    interval = setInterval(function() {
      if(words.length > 0) {
        sendWordToColoringApi(words.shift());
      }
      else{
        clearInterval(interval);
      }

    }, 60000/parseInt(wordsPerMin));

    $('#start-reading-button').removeAttr('disabled');
    $('#glyphicon-pause-button').removeAttr('disabled');
    $('#glyphicon-resume-button').removeAttr('disabled');
  };

  var pauseText = function () {
    clearInterval(interval);
    delete(interval);
    $("#start-reading-button").attr('disabled','disabled');
    $('#glyphicon-pause-button').attr('disabled','disabled');
    $('#glyphicon-resume-button').removeAttr('disabled');
  };

  var resumeText = function () {
    playText();
    $("#start-reading-button").attr('disabled','disabled');
    $('#glyphicon-pause-button').removeAttr('disabled');
    $('#glyphicon-resume-button').attr('disabled','disabled');
  };

  var sendWordToColoringApi = function(word){
    var colorScheme = $('.color-scheme .dropdown-toggle .selection').attr('value');
    $.ajax({
      url: Reader.config.coloring_service_url,
      type: 'POST',
      contenttype:'application/json; charset=utf-8',
      data: JSON.stringify({
        words: [word],
        color_scheme: colorScheme,
        pusher_notification_channel: pusherChannel
      }),
      crossDomain: true,
      dataType:'json',
      success: function() {
        alert( "success" );
      }
    });
  };

  $(document).ready(function() {
    init();
  });
})();

