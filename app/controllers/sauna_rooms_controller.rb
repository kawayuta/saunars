class SaunaRoomsController < ApplicationController
  before_action :set_sauna_room, only: %i[ show edit update destroy ]

  # GET /sauna_rooms or /sauna_rooms.json
  def index
    @sauna_rooms = SaunaRoom.all
  end

  # GET /sauna_rooms/1 or /sauna_rooms/1.json
  def show
  end

  # GET /sauna_rooms/new
  def new
    @sauna_room = SaunaRoom.new
  end

  # GET /sauna_rooms/1/edit
  def edit
  end

  # POST /sauna_rooms or /sauna_rooms.json
  def create
    @sauna_room = SaunaRoom.new(sauna_room_params)

    respond_to do |format|
      if @sauna_room.save
        format.html { redirect_to @sauna_room, notice: "Sauna room was successfully created." }
        format.json { render :show, status: :created, location: @sauna_room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sauna_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sauna_rooms/1 or /sauna_rooms/1.json
  def update
    respond_to do |format|
      if @sauna_room.update(sauna_room_params)
        format.html { redirect_to @sauna_room, notice: "Sauna room was successfully updated." }
        format.json { render :show, status: :ok, location: @sauna_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sauna_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sauna_rooms/1 or /sauna_rooms/1.json
  def destroy
    @sauna_room.destroy
    respond_to do |format|
      format.html { redirect_to sauna_rooms_url, notice: "Sauna room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sauna_room
      @sauna_room = SaunaRoom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sauna_room_params
      params.require(:sauna_room).permit(:sauna_temperature, :gender)
    end
end
