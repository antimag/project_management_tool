class TodosController < ApplicationController
  load_and_authorize_resource except: :update_status
  skip_authorization_check only: :update_status
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :set_projects_and_users, only: [:new, :edit, :create, :update]

  def index
    @todos = current_user.is_admin? ? Todo.all : current_user.todos
  end

  def show
  end


  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
    end
  end

  def update_status
    if @todo.update_attributes(todo_params)
      data = (todo_params.key?("user_id") ? @todo.user.name : @todo.todo_status.name.capitalize).titleize rescue ''
      render json: { status: 200, data: data, message: "Status updated successfully."}
    else
      render json: {status: 201, message: @todo.errors.full_messages.join(",")}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end
    
    def set_projects_and_users
      @projects = Project.all
      @users = User.developers
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :description, :due_date, :todo_status_id, :project_id, :user_id)
    end
end
