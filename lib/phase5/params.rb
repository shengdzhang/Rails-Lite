require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = parse_www_encoded_form(req.query_string)
      @params.deep_merge!(parse_www_encoded_form(req.body))
      @params.deep_merge!(route_params)
      # byebug
    end

    def [](key)
      @params[key.to_s].nil? ? @params[key.to_sym] : @params[key.to_s]

    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return {} unless www_encoded_form
      params = {}
      URI.decode_www_form(www_encoded_form).each do |key, value|
        current = params
        keys = parse_key(key)
        last = keys.pop
        keys.each do |kay|
          current[kay]||={}
          current = current[kay]
        end
        current[last]=value
      end
      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
