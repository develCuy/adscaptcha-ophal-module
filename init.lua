_M = {
}
ophal.modules.adscaptcha = _M

local config = settings.adscaptcha
local AdsCaptcha, _SERVER, add_js = require 'adscaptcha', _SERVER, add_js
local type = type

function _M.form_alter(variables)
  for entity_type in pairs(config.entities) do
    if variables.id == entity_type .. '_create_form' or variables.id == entity_type .. '_edit_form' then
      add_js{'modules/adscaptcha/adscaptcha.js'}
      variables.elements[1 + #variables.elements] = {'markup', value = AdsCaptcha.getCaptcha(config.captchaId, config.publicKey), weight = -1}
    end
  end
end

function _M.entity_before_save(entity)
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

return _M
