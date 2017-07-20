class UserMailer < ApplicationMailer

  def added_as_member_project project_id, adder_id, role_id
    @project = Project.find(project_id)
    @role    = Role.find(role_id)
    @user    = @role.user
    @adder   = User.find(adder_id)

    mail(to: @user.email,
         subject: "Cellar | You have been added as a member
         (#{Project.parse_role(@role.level)}) in project '#{@project.name}'")
  end

end
