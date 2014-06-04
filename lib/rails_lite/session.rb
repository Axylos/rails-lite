require 'json'
require 'webrick'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    app_cookie = req.cookies.find { |el| el.name == "_rails_lite_app" }
    
    if app_cookie.nil?
      @session = {}
    else 
      cookie = app_cookie.value
      @session = JSON.parse(cookie)
    end
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    j_sess = @session.to_json
    cookie = WEBrick::Cookie.new("_rails_lite_app", j_sess)
    res.cookies << cookie
  end
end
