class User::ComicDetailController < ApplicationController
  private

  def comic_detail_params
    params.require(:comic_detail).permit(:user_id, :volume_id, :tag_id, :story, :purchase_place, :version, :comic_size)
  end

end
