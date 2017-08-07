class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected

    def find_project
      @project = Project.find_by!(slug: params[:slug])
    end
end
