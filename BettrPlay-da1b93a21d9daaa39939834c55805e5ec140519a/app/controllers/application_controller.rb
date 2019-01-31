class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :photo, :first_name, :last_name])
  end

  def activities_for_ticker
    @activities = Activity.all
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def after_sign_in_path_for(resource)
    challenges_path
  end
  # class SessionsController < Devise::SessionsController

  #     def create
  #       current_user.update(last_signin: Time.now)
  #       super
  #     end

  #     def destroy
  #       current_user.update(last_sign_out: Time.now)
  #       super
  #     end

  # end


end

