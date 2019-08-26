class DashboardsController < ApplicationController
  skip_authorization_check
  before_action :is_authorized?
  def graphs
    @project_ids = Project.all.ids
  end

  def developers_todo_list
    @developers = User.developers
    @headers = @developers.map(&:full_name)
    @status = TodoStatus.all
  end

  def project_todo_list
    @projects = Project.all
    @headers = @projects.map(&:project_name)
    @status = TodoStatus.all
  end

  private
   def is_authorized?
     redirect_to todos_path, alert: "You are not authorized for this page!"  unless current_user.is_admin? 
   end

end
