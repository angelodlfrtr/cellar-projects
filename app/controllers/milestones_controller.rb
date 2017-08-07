class MilestonesController < ApplicationController
  include ParamsHelper
  before_action :find_project

  def index
    page = parse_page(params[:page])
    per  = parse_per(params[:per])

    @milestones = @project.milestones.page(page).per(per)
  end

  def new
    @milestone = Milestone.new
  end

  def create
    @milestone            = Milestone.new(milestone_params)
    @milestone.project_id = @project.id

    if @milestone.save
      redirect_to milestones_path(@project.slug)
    else
      render action: :new
    end
  end

  private

    def milestone_params
      params.require(:milestone).permit(:name, :deadline)
    end
end
