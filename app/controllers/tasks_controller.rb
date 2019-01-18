class TasksController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
  	@task = Task.new
  end

  def create
  	@task = Task.new(task_params.merge(user_id: current_user.id))
    if @task.save
    redirect_to tasks_path, :flash => {:notice => "タスク『#{@task.name}』を登録しました。"}
    else
    render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_path, :flash => {:notice => "タスク『#{task.name}』を更新しました。"}
  end

  def destroy
    task = Task.find(params[:id])
    task.delete
    redirect_to tasks_path, :flash => {:notice => "タスク『#{task.name}』を削除しました。"}
  end

  private

  def task_params
  	params.require(:task).permit(:name, :description)
  end

end
