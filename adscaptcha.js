(function($) {

$(document).ready(function() {
  $(document).bind('ophal:entity:save', function(event, data) {
    if (data.entity.type = 'comment') {
      data.entity.adscaptcha_challenge_field = $('#adscaptcha_challenge_field', data.context).val();
      data.entity.adscaptcha_response_field = $('#adscaptcha_response_field', data.context).val();
    }
  });
});

})(jQuery);