#Create Todo Status i.e. Done, In Progress, New
["done","in_progress", "new"].each do|status|
  TodoStatus.where(name: status).first_or_create
end
todo_status_id = TodoStatus.find_by_name("new").id
admin_user = User.where(email: "antima.gupta@mailinator.com", name: "antima", is_admin: true).first_or_create({:password => "admin@123", :password_confirmation => "admin@123" })
puts "Admin login credentials (email/password): (antima.gupta@mailinator.com/admin@123)"
data = ["A","B", "C", "D", "E"]
data.each do|data_item|
  full_name = "Dev #{data_item}"
  user = User.where(email: "#{full_name.downcase.tr!(" ", "_")}@mailinator.com", name: full_name, is_admin: false).first_or_create({:password => "dev123", :password_confirmation => "dev123" })
  puts "Developer login credentials (email/password): (dev_a@mailinator.com/dev123)"

  project = Project.where(name: "Project #{data_item}").first_or_create
  (1..7).to_a.each do|num|
    Todo.where(title: "Task #{data_item+num.to_s}",
                description: "Task #{data_item+num.to_s}",
                project_id: project.id,
                user_id: user.id,
                todo_status_id: todo_status_id
              ).first_or_create(due_date: (Time.now+10.days))
  end
end