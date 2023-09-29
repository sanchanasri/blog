class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
end

end
