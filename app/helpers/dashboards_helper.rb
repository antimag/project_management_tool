module DashboardsHelper
  def get_user_todo_by_status(user_id,status_id)
    User.find(user_id).todos.todo_by_status_id(status_id)
  end
  def get_project_todo_by_status(project_id,status_id)
    Project.find(project_id).todos.todo_by_status_id(status_id)
  end
end
