class TasksController < ApplicationController
  before_action :require_user_logged_in #application_controllerで定義されている。action前にログインを確認する
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :destroy, :update]
  
  def index
    @task = current_user.tasks.build
    @tasks = current_user.tasks.order(id: :desc)
    @user = User.find(session[:user_id])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(tasks_params)
    if @task.save
      flash[:success] = 'Taskを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc)
      flash.now[:danger] = 'Taskの投稿に失敗しました。'
      render :new
    end
  end

  def update
    if @task.update(tasks_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to tasks_url
    # redirect_back(fallback_location: root_path)
  end
  
  def edit
  end
  
  
  
  private
  
  def tasks_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end
  #同じコードを共通化。GET,POSTやURLのパラメータやデータは全てparamsに代入されて受け取れます
end



