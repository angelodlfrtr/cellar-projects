class TasksController < ApplicationController
  include ParamsHelper
  before_action :find_project

  def index
    page   = parse_page(params[:page])
    @tasks = @project.tasks

    if params[:only_me] == '1'
      @tasks = @tasks.where(assigned_id: current_user.id)
    end

    if params[:closed] == '1'
      @tasks = @tasks.closed
    else
      @tasks = @tasks.opened
    end

    @tasks = @tasks.order(updated_at: :desc).page(page)
  end

  def new
    @task = Task.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
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

  def update
    @task = @project.tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to task_path(@project.slug, @task.id)
    else
      render action: :edit
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

  def destroy
    @task = @project.tasks.find(params[:id])

    @task.update!(deleted: 1)
    @task.generate_deletion_internal_event(current_user.id)

    redirect_to tasks_path(@project.slug)
  end

  private

    def task_params
      params.require(:task).permit(:name, :description, :deadline, :assigned_id)
    end

    def find_project
      @project = Project.find_by(slug: params[:slug])
    end
end
