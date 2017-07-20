class ProjectsController < ApplicationController
  include ParamsHelper

  def index
    page      = parse_page(params[:page])
    @projects = current_user.projects.page(page)
  end

  def new
    @project = Project.new
  end

  def show
    @project         = Project.find_by!(slug: params[:slug])
    @internal_events = @project.internal_events.order(created_at: :desc).page(1)
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      @project.join_user(current_user, :owner)
      @project.generate_creation_internal_event!

      redirect_to project_path(@project.slug)
    else
      render action: :new
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :deadline)
    end
end
