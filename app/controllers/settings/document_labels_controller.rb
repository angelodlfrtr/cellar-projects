class Settings::DocumentLabelsController < SettingsController

  def index
    @labels = @project.document_labels
    @label  = DocumentLabel.new
  end

  def create
    @label            = DocumentLabel.new(document_label_params)
    @label.project_id = @project.id

    @label.save
    redirect_to settings_document_labels_path(@project.slug)
  end

  def destroy
    @label = @project.document_labels.find(params[:id])
    @label.destroy
    redirect_to settings_document_labels_path(@project.slug)
  end

  private

    def document_label_params
      params.require(:document_label).permit(:name, :color_code)
    end
end
