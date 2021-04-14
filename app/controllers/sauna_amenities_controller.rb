class SaunaAmenitiesController < ApplicationController
  before_action :set_sauna_amenity, only: %i[ show edit update destroy ]

  # GET /sauna_amenities or /sauna_amenities.json
  def index
    @sauna_amenities = SaunaAmenity.all
  end

  # GET /sauna_amenities/1 or /sauna_amenities/1.json
  def show
  end

  # GET /sauna_amenities/new
  def new
    @sauna_amenity = SaunaAmenity.new
  end

  # GET /sauna_amenities/1/edit
  def edit
  end

  # POST /sauna_amenities or /sauna_amenities.json
  def create
    @sauna_amenity = SaunaAmenity.new(sauna_amenity_params)

    respond_to do |format|
      if @sauna_amenity.save
        format.html { redirect_to @sauna_amenity, notice: "Sauna amenity was successfully created." }
        format.json { render :show, status: :created, location: @sauna_amenity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sauna_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sauna_amenities/1 or /sauna_amenities/1.json
  def update
    respond_to do |format|
      if @sauna_amenity.update(sauna_amenity_params)
        format.html { redirect_to @sauna_amenity, notice: "Sauna amenity was successfully updated." }
        format.json { render :show, status: :ok, location: @sauna_amenity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sauna_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sauna_amenities/1 or /sauna_amenities/1.json
  def destroy
    @sauna_amenity.destroy
    respond_to do |format|
      format.html { redirect_to sauna_amenities_url, notice: "Sauna amenity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sauna_amenity
      @sauna_amenity = SaunaAmenity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sauna_amenity_params
      params.require(:sauna_amenity).permit(:name_ja)
    end
end
