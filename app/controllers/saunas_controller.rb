require 'uri'
require "addressable/uri"

class SaunasController < ApplicationController
  before_action :set_sauna, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ recommend ]
  # GET /saunas or /saunas.json
  def index
    unless params[:sort].blank?
      sort = params[:sort].to_s
      if sort == "pop"
        @saunas = cache_went_ranking.page(params[:page]).per(20)
      end
    else
      word = params[:search_word].to_s
      @saunas = Sauna.es_search(word).records
    end
  end

  def search
    word = search_params[:name_ja_or_address_cont].to_s
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    currentLatitude = params[:currentLatitude].to_f
    currentLongitude = params[:currentLongitude].to_f
    radius = params[:radius].to_i
    sortType = params[:sortType].to_s

    if currentLatitude == 0 || currentLongitude == 0
    # version 1.0
      @search_saunas = Sauna.es_search(word, latitude, longitude, radius).records.ransack(search_params).result(distinct: true)
    else
      # version 2.0
      if sortType == "0"
        @search_saunas = Sauna.es_currentLocation_search(word, latitude, longitude, radius, currentLatitude, currentLongitude, sortType).records.ransack(search_params).result(distinct: true)
      elsif sortType == "1" || sortType == "2"
        @search_saunas = Sauna.es_price_search(word, latitude, longitude, radius, sortType).records.ransack(search_params).result(distinct: true)
      end
    end
  end

  def incremental_search
    word = search_params[:name_ja_or_address_cont].to_s
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    currentLatitude = params[:currentLatitude].to_f
    currentLongitude = params[:currentLongitude].to_f
    radius = params[:radius].to_i
    sortType = params[:sortType].to_s
    @incremental_search = Sauna.es_incremental_search(word, latitude, longitude, radius, currentLatitude, currentLongitude, sortType).records.ransack(search_params).result(distinct: true)
    render json: @incremental_search
  end

  def recommend

    word = search_params[:name_ja_or_address_cont].to_s
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    currentLatitude = params[:currentLatitude].to_f
    currentLongitude = params[:currentLongitude].to_f
    radius = params[:radius].to_i
    sortType = params[:sortType].to_s
    type = params[:type].to_s
    wents = current_user.wents.limit(30).shuffle.pluck(:sauna_id)

    unless type.blank?
      if type == "location"
        if wents.count > 4
          @recommend_saunas = Sauna.es_recommend_currentLocation_search(wents, currentLatitude, currentLongitude).records.limit(30)
        else
          @recommend_saunas = Sauna.es_currentLocation_search("", currentLatitude, currentLongitude, 30, currentLatitude, currentLongitude, 0).records.limit(30)
        end
      end

    else
      if wents.count > 4
        @recommend_saunas = Sauna.es_recommend_search(wents).records.limit(30)
      else
        @recommend_saunas = Sauna.all.limit(10)
      end
    end

  end

  

  # GET /saunas/1 or /saunas/1.json
  def show
    
  end

  # GET /saunas/new
  def new
    @sauna = Sauna.new
  end

  # GET /saunas/1/edit
  def edit
  end

  # POST /saunas or /saunas.json
  def create
    @sauna = Sauna.new(sauna_params)

    respond_to do |format|
      if @sauna.save
        format.html { redirect_to @sauna, notice: "Sauna was successfully created." }
        format.json { render :show, status: :created, location: @sauna }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sauna.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saunas/1 or /saunas/1.json
  def update
    respond_to do |format|
      if @sauna.update(sauna_params)
        format.html { redirect_to @sauna, notice: "Sauna was successfully updated." }
        format.json { render :show, status: :ok, location: @sauna }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sauna.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saunas/1 or /saunas/1.json
  def destroy
    @sauna.destroy
    respond_to do |format|
      format.html { redirect_to saunas_url, notice: "Sauna was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def cache_went_ranking
      Rails.cache.fetch("cache_went_rank", expires_in: 60.minutes) do
        Kaminari.paginate_array(Sauna.all.sort_by {|sauna| sauna.wents.size}.reverse)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sauna
      @sauna = Sauna.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sauna_params
      params.require(:sauna).permit(:name_ja, :address)
    end


    def recommend_params
      params.permit(ids: [])
    end

    def search_params
      params.require(:q).permit(
        :name_ja_or_address_cont,
        :sauna_roles_loyly_eq,
        :sauna_roles_self_loyly_eq,
        :sauna_roles_auto_loyly_eq,
        :sauna_roles_gaikiyoku_cont,
        :sauna_roles_rest_space_cont,
        :sauna_tags_title_cont,


        :sauna_roles_free_time_cont,
        :sauna_roles_capsule_hotel_cont,
        :sauna_roles_in_rest_space_cont,
        :sauna_roles_eat_space_cont,
        :sauna_roles_wifi_cont,
        :sauna_roles_power_source_cont,
        :sauna_roles_work_space_cont,
        :sauna_roles_manga_cont,
        :sauna_roles_body_care_cont,
        :sauna_roles_body_towel_cont,
        :sauna_roles_water_dispenser_cont,
        :sauna_roles_washlet_cont,
        :sauna_roles_credit_settlement_cont,
        :sauna_roles_parking_area_cont,
        :sauna_roles_ganbanyoku_cont,
        :sauna_roles_tattoo_cont,


        :sauna_amenities_shampoo_cont,
        :sauna_amenities_conditioner_cont,
        :sauna_amenities_body_soap_cont,
        :sauna_amenities_face_soap_cont,
        :sauna_amenities_razor_cont,
        :sauna_amenities_toothbrush_cont,
        :sauna_amenities_nylon_towel_cont,
        :sauna_amenities_hairdryer_cont,
        :sauna_amenities_face_towel_unlimited_cont,
        :sauna_amenities_bath_towel_unlimited_cont,
        :sauna_amenities_sauna_underpants_unlimited_cont,
        :sauna_amenities_sauna_mat_unlimited_cont,
        :sauna_amenities_flutterboard_unlimited_cont,
        :sauna_amenities_toner_cont,
        :sauna_amenities_emulsion_cont,
        :sauna_amenities_makeup_remover_cont,
        :sauna_amenities_cotton_swab_cont,
        )
    end
end
