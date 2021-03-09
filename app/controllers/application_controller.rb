class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception
    rescue_from Pundit::NotAuthorizedError, with: :pundit_error
    before_action :callback, if: :devise_controller?

    private

    def pundit_error
        flash[:notice] = 'Not Allowed to edit this Threads !!!'
        redirect_to forum_thread_path()
    end

    def callback
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
