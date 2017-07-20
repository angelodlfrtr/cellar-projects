class TasksController < ApplicationController
  before_action :find_project

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task         = Task.new(task_params)
    @task.user    = current_user
    @task.project = @project

    if @task.save
      redirect_to task_path(@project.slug, @task.id)
    else
      render action: :new
    end
  end

  def show
    @task     = @project.tasks.find(params[:id])
    @comments = @task.get_comments_with_events
    @comment  = TaskComment.new
  end

  def close
    @task = @project.tasks.find(params[:id])
    @task.close!(current_user)
    redirect_to task_path(@project.slug, @task.id)
  end

  def reopen
    @task = @project.tasks.find(params[:id])
    @task.reopen!(current_user)
    redirect_to task_path(@project.slug, @task.id)
  end

  private

    def task_params
      params.require(:task).permit(:name, :description, :start_date, :end_date, :assigned_id)
    end

    def find_project
      @project = Project.find_by(slug: params[:slug])
    end
end
