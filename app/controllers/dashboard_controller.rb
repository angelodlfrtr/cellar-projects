class DashboardController < ApplicationController
  def index
    @projects = current_user.projects.page(1).per(10)
  end
end
