class Settings::MembersController < SettingsController

  def index
    @members = @project.users
  end

  def add
    role            = Role.new(add_member_params)
    role.project_id = @project.id

    role.save

    redirect_to settings_members_path(@project.slug) + "/#member_#{role.user_id}"
  end

  private

    def add_member_params
      params.permit(:user_id, :level)
    end
end
