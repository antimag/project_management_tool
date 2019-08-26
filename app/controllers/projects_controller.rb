class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_project, only: [:graph, :show, :edit, :update, :destroy, :add_developers, :save_developers]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def add_developers
    @users  = User.all.where("is_admin = ?", false)
  end

  def save_developers
    selected_users = []
    params[:project][:user_ids].each {|id| selected_users << id.to_i if id.to_i> 0 }
    @project.users.delete_all
    params[:project][:user_ids].each do|user_id|
      user = User.find(user_id) rescue nil
      @project.users
      @project.users << user if (user.present? && !@project.users.include?(user))
    end
    respond_to do |format|
      if @project.errors.blank?
        format.html { redirect_to projects_path, notice: 'Project\'s developers were successfully added.' }
      else
        format.html { render :add_developers }
      end
    end
  end
  def graph
     graph = @project.todos.joins(:todo_status).group("todo_statuses.name").count.to_a rescue []
     render json: { status: 200, data: graph, title: @project.name, id: @project.id  }
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
    def developers
      params.require
    end
end
