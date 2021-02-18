class LabelsController < ApplicationController
  before_action :set_label, only:[:destroy]
  before_action :authenticate_user, only:[:new, :destroy]
  before_action :ensure_current_user_label_check, only:[:destroy]
  def new
    @label = Label.new
  end
  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to user_path(current_user.id), notice: "ラベルを作成しました。"
    else
      render :new
    end
  end
  def destroy
    @label.destroy
    redirect_to tasks_path, notice: "ラベルを削除しました。"
  end
  private
  def label_params
    params.require(:label).permit(:name)
  end
  def set_label
    @label = Label.find(params[:id])
  end
end
