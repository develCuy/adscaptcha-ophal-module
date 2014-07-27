local config = settings.adscaptcha
local AdsCaptcha, _SERVER, add_js = require 'adscaptcha', _SERVER, add_js
local type = type

module 'ophal.modules.adscaptcha'

function form_alter(variables)
  if variables.id == 'comment_form' then
    add_js{'modules/adscaptcha/adscaptcha.js'}
    variables.elements[1 + #variables.elements] = {'markup', value = AdsCaptcha.getCaptcha(config.captchaId, config.publicKey), weight = -1}
  end
end

function entity_before_save(variables)
  local res

  if not config.entities[entity.type] then return end

  if variables.adscaptcha_challenge_field and variables.adscaptcha_response_field then
    res = AdsCaptcha.validateCaptcha(
      config.captchaId,
      config.privateKey,
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
