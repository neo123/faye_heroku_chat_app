class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def twitter
    data = request.env["omniauth.auth"].info
    @twitr = Twitr.new(:user_id => current_user.id, :username => data[:nickname])
    @twitr.save
    redirect_to home_index_path
  end
  
  def failure
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
  
  def passthru
  render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  # Or alternatively,
  # raise ActionController::RoutingError.new('Not Found')
  end

end
