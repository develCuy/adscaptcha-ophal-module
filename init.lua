local AdsCaptcha, _SERVER, add_js = require 'adscaptcha', _SERVER, add_js
local acConfig = settings.adscaptcha

module 'ophal.modules.adscaptcha'

function form_alter(variables)
  if variables.id == 'comment_form' then
    add_js{'modules/adscaptcha/adscaptcha.js'}
    variables.elements[1 + #variables.elements] = {'markup', value = AdsCaptcha.getCaptcha(acConfig.captchaId, acConfig.publicKey), weight = -1}
  end
end

function entity_before_save(variables)
  if variables.type == 'comment' then
    local ret = AdsCaptcha.validateCaptcha(
      acConfig.captchaId,
      acConfig.privateKey,
      variables.adscaptcha_challenge_field,
      variables.adscaptcha_response_field,
      _SERVER 'REMOTE_ADDR'
    )
  end
end
