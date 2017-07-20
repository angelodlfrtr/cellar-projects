class Settings::MembersController < SettingsController

  def index
    @members = @project.users
  end

  def add
    role = @project.join_user(User.find(params[:user_id]), params[:level].to_i)

    @project.generate_add_member_internal_event(current_user.id, role.id)
    UserMailer.added_as_member_project(@project.id, current_user.id, role.id).deliver_now

    redirect_to settings_members_path(@project.slug) + "/#member_#{role.user_id}"
  end

  private

    def add_member_params
      params.permit(:user_id, :level)
    end
end
