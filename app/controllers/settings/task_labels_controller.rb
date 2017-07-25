class Settings::TaskLabelsController < SettingsController

  def index
    @labels = @project.task_labels
    @label  = TaskLabel.new
  end

  def create
    @label            = TaskLabel.new(task_label_params)
    @label.project_id = @project.id

    @label.save
    redirect_to settings_task_labels_path(@project.slug)
  end

  def destroy
    @label = @project.task_labels.find(params[:id])
    @label.destroy
    redirect_to settings_task_labels_path(@project.slug)
  end

  private

    def task_label_params
      params.require(:task_label).permit(:name, :color_code)
    end
end
