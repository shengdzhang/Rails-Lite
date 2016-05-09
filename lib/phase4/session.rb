require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash

    def initialize(req)
      @cookie = {}
      # byebug
      req.cookies.each do |cookie|
        if cookie.name == '_rails_lite_app'
          temp = JSON.parse(cookie.value)
          @cookie = temp unless temp.nil?
          break
        end
      end

    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key]=val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      new_cook = WEBrick::Cookie.new('_rails_lite_app',@cookie.to_json)
      # debugger
      if res.cookies.nil?
        res.cookies = [new_cook]
      else
        res.cookies << new_cook
      end
    end
  end
end
