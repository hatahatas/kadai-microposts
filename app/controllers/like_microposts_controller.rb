class LikeMicropostsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.liked(micropost)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_to root_url
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unliked(micropost)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to root_url
  end
end
