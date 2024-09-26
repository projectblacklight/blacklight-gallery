module ViewComponentV2TestHelpers
  def vc_test_controller
    @vc_test_controller ||= __vc_test_helpers_build_controller(ViewComponent::Base.test_controller.constantize)
  end

  def __vc_test_helpers_build_controller(klass)
    klass.new.tap { |c| c.request = vc_test_request }.extend(Rails.application.routes.url_helpers)
  end

  def vc_test_request
    require "action_controller/test_case"

    @vc_test_request ||=
      begin
        out = ActionDispatch::TestRequest.create
        out.session = ActionController::TestSession.new
        out
      end
  end
end