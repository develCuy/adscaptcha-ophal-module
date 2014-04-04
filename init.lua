local AdsCaptcha, _SERVER, add_js = require 'adscaptcha', _SERVER, add_js
local acConfig, type = settings.adscaptcha, type

local debug = debug

module 'ophal.modules.adscaptcha'

function form_alter(variables)
  if variables.id == 'comment_form' then
    add_js{'modules/adscaptcha/adscaptcha.js'}
    variables.elements[1 + #variables.elements] = {'markup', value = AdsCaptcha.getCaptcha(acConfig.captchaId, acConfig.publicKey), weight = -1}
  end
end

function entity_before_save(variables)
  local res

  if variables.type == 'comment' then
    res = AdsCaptcha.validateCaptcha(
      acConfig.captchaId,
      acConfig.privateKey,
      variables.adscaptcha_challenge_field,
      variables.adscaptcha_response_field,
      _SERVER 'REMOTE_ADDR'
    )
    if type(res) == 'table' and true == res.response then
      return true
    else
      return nil, 'Invalid captcha answer!'
    end
  end
end
