require_relative '../phase5/controller_base'
# require 'byebug'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(action_name)
      # byebug
      self.send(action_name)
      render(action_name) unless already_built_response?
    end
  end
end
