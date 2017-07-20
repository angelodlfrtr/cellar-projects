class TaskCommentsController < ApplicationController
  before_action :find_project, :find_task

  def create
    @comment         = TaskComment.new(task_comment_params)
    @comment.user_id = current_user.id
    @comment.task_id = @task.id

    if @comment.save
      redirect_to task_path(@project.slug, @task.id) + "#comment_#{@comment.id}"
    else
    end
  end

  private

    def task_comment_params
      params.require(:task_comment).permit(:content)
    end

    def find_project
      @project = Project.find_by!(slug: params[:slug])
    end

    def find_task
      @task = @project.tasks.find(params[:id])
    end
end
