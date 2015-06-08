module OauthStub
  def set_omniauth(opts = {})
    default = {:provider => :facebook,
               :uid     => "1234",
               :info => {
                          :email => "foobar@example.com"
                        }
              }
  
    credentials = default.merge(opts)
    provider = credentials[:provider]
    user_hash = credentials[:info]
  
    OmniAuth.config.test_mode = true
  
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      "provider" => provider,
      "uid" => credentials[:uid],
      "info" => {
        "email" => user_hash[:email]
        }
    })
  end

  def set_invalid_omniauth(opts = {})  
    credentials = OmniAuth::AuthHash.new({ :provider => :facebook,
                    :invalid  => :invalid_crendentials
                   }).merge(opts)
  
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
  end
end 