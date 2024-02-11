class User::VolumesController < ApplicationController

  def index
    @volumes = current_user.volumes.order(:name)
  end

  def destroy
    @volume = Volume.find(params[:id])
    # タグを削除できるのは、作成者のみ
    if @volume.user_id == current_user.id
      @volume.destroy
      redirect_to tags_path, notice: '指定された巻数が削除されました。'
    else
      flash[:alert] = '他のユーザーの巻数を削除することはできません。'
      redirect_to tas_path
    end
  end

  private

  def volume_params
    params.require(:volume).permit(:name)
  end

end
