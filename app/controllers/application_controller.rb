class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :body_classes
  def body_classes
    @body_classes ||= [params[:controller], params[:action]]
  end

  def body_classes=(data)
    @body_classes = data
  end
end
