class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :are_you_new?

  private
  def are_you_new?
    this_id = request.session_options[:id]
    User.find_or_create_by(session_id: this_id)
  end
end
