class DocumentsController < ApplicationController
  include ParamsHelper
  before_action :find_project

  def index
    page = parse_page(params[:page])

    @documents = @project.documents

    # Uploaded by me
    @documents = @documents.where(user_id: current_user.id)

    # Filter by labels
    label_ids = []

    if params[:labels]
      if params[:labels].kind_of?(Array)
        params[:labels].each { |m| label_ids.push(m.to_i).delete_if { |n| n == 0 } }
      end
    end

    if label_ids.length > 0
      @documents = @documents.joins(:document_labels).where('document_labels.id' => label_ids)
    end


    # Paginate
    @documents = @documents.page(page)
  end

  def new
    @document = Document.new
  end

  def create
    @document            = Document.new(document_params)
    @document.project_id = @project.id
    @document.user_id    = current_user.id

    if @document.save
      @file_upload = FileUpload.new(klass: :document, klass_id: @document.id, file: file_params[:file])

      if @file_upload.save
        redirect_to documents_path(@project.slug)
      else
        @document.destroy
        raise @document.errors.inspect
        render action: :new
      end
    else
      raise @document.errors.inspect
      render action: :new
    end
  end

  def destroy
    @document = @project.documents.find(params[:id])

    @document.destroy!
    redirect_to documents_path(@project.slug)
  end

  private

    def document_params
      params.require(:document).permit(:name, document_label_ids: [])
    end

    def file_params
      params.require(:document).permit(:file)
    end
end
