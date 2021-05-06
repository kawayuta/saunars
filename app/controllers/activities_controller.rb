
require 'json'
class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  protect_from_forgery
  # before_action :authenticate_user!

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1 or /activities/1.json
  def show 
    # render json: { activities: current_user.activities.find_by(sauna_id: params[:id])}
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create

    if activity_params[:images].present?
      imgArray = []
      activity_params[:images].each do |d|
        imgArray.append(Activity.decode_base64_image(d))
      end
      attrs = activity_params
      attrs[:images] = imgArray
      @activity = Activity.new(attrs)

      begin
        respond_to do |format|
          if @activity.save && imgArray && @activity.save(images: imgArray)
            format.html { redirect_to @activity, notice: "Activity was successfully created." }
            format.json { render :show, status: :created, location: @activity }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @activity.errors, status: :unprocessable_entity }
          end
        end
      ensure
        imgArray.each do |d|
          d.close
          d.unlink
        end
      end
      
    else
      @activity = Activity.new(activity_params)
      respond_to do |format|
        if @activity.save
          format.html { redirect_to @activity, notice: "Activity was successfully created." }
          format.json { render :show, status: :created, location: @activity }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end




  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: "Activity was successfully updated." }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    
    def activity_params
      params.permit(:sauna_id, :user_id, :body, :image, :sauna_time, :sauna_count, :mizuburo_time, :mizuburo_count, :rest_time, :rest_count, images: [], review_attributes: [:id, :sauna_id, :user_id, :cleanliness, :customer_service, :equipment, :customer_manner, :cost_performance])
    end


end
