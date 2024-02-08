class User::VolumesController < ApplicationController
  
  private

  def volume_params
    params.require(:volume).permit(:name)
  end
  
end
