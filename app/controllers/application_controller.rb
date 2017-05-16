class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  private

  # def are_you_new?
  #   # this_id = request.session_options[:id]
  #   # @current_user = User.find_or_create_by(session_id: this_id)
  #   # current_user
  # end

  def current_user
    @current_user ||= if session.id
      User.find_or_create_by!(session_id: session.id)
    else
      reset_session
      User.find_or_create_by!(session_id: session.id)
    end
  end
end
