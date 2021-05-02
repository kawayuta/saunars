class WentsController < ApplicationController
    protect_from_forgery

    # before_action :set_went, only: %i[ show ]
    before_action :authenticate_user!

    def show 
      render json: { is_went: current_user.wents.find_by(sauna_id: params[:id]).present?}
    end


    def create
        SaunaWentWorker.perform_async("create", current_user.id, went_params[:sauna_id])
        # @went = current_user.wents.new(went_params)
        
        # respond_to do |format|
        #   if @went.save
        #     format.json { render :show, status: 200, location: @went }
        #   else
        #     format.json { render json: @went.errors, status: 404 }
        #   end
        # end
      end
    
      def destroy

        SaunaWentWorker.perform_async("destroy", current_user.id, params[:sauna_id])
        # @went = Went.find_by(sauna_id: params[:sauna_id], user_id: current_user.id)
        # @went.destroy
        # redirect_back(fallback_location: root_path)
      end

      private

      def set_went
        @went = current_user.wents.find(params[:id])
      end

      def went_params
        params.require(:went).permit(:sauna_id)
      end
end
