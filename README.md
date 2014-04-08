AdsCaptcha Ophal Module
=======================

Minteye's AdsCaptcha integration for Ophal.


### Configuration

1. Deploy a copy of this module into 'modules' folder, and name it 'adscaptcha',
   so the init.lua file is located at modules/adscaptcha/init.lua

2. Add the following code to your settings.lua:

        --[=[ Enable AdsCaptcha module ]=]
        settings.modules.adscaptcha = true
        
        --[=[
          AdsCaptcha module settings.
        ]=]
        settings.adscaptcha = {
          captchaId = 99999,
          publicKey = 'captcha-public-key',
          privateKey = 'captcha-private-key',
        }
