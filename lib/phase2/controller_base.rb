require 'byebug'

module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res, route_params = {})
      @cookies = req.cookies
      @res = res
      @req = req
      @ares = false
      # Params.new(req, route_params)
    end

    # Helper method to alias @already_built_response
    def already_built_response?
        @ares
    end

    # Set the response status code and header
    def redirect_to(url)
      @res.header["location"] = url
      @res.status = 302
      if @ares
        raise Exception
      else
        @ares = true
      end
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      @res.content_type = content_type
      @res.body = content
      if @ares
        raise Exception
      else
        @ares = true
      end
    end
  end
end
