class LikesController < ApplicationController
#   before_action :set_like, only: %i[ show edit update destroy ]
  protect_from_forgery
  # before_action :authenticate_user!

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
    render json: {
      is_like: current_user.likes.find_by(activity_id: params[:id]).present?,
      like_count: Like.where(activity_id: params[:id]).count
    }
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    ActivityLikeWorker.perform_async("create", current_user.id, like_params[:activity_id])
  end

  def destroy

    ActivityLikeWorker.perform_async("destroy", current_user.id, params[:activity_id])
    # @went = Went.find_by(sauna_id: params[:sauna_id], user_id: current_user.id)
    # @went.destroy
    # redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:activity_id, :user_id)
    end
end
