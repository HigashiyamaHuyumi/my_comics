class User::VolumesController < ApplicationController
  
  private

  def volume_params
    params.require(:volume).permit(:user_id, :name)
  end
  
end
