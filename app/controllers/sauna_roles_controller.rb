class SaunaRolesController < ApplicationController
  before_action :set_sauna_role, only: %i[ show edit update destroy ]

  # GET /sauna_roles or /sauna_roles.json
  def index
    @sauna_roles = SaunaRole.all
  end

  # GET /sauna_roles/1 or /sauna_roles/1.json
  def show
  end

  # GET /sauna_roles/new
  def new
    @sauna_role = SaunaRole.new
  end

  # GET /sauna_roles/1/edit
  def edit
  end

  # POST /sauna_roles or /sauna_roles.json
  def create
    @sauna_role = SaunaRole.new(sauna_role_params)

    respond_to do |format|
      if @sauna_role.save
        format.html { redirect_to @sauna_role, notice: "Sauna role was successfully created." }
        format.json { render :show, status: :created, location: @sauna_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sauna_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sauna_roles/1 or /sauna_roles/1.json
  def update
    respond_to do |format|
      if @sauna_role.update(sauna_role_params)
        format.html { redirect_to @sauna_role, notice: "Sauna role was successfully updated." }
        format.json { render :show, status: :ok, location: @sauna_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sauna_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sauna_roles/1 or /sauna_roles/1.json
  def destroy
    @sauna_role.destroy
    respond_to do |format|
      format.html { redirect_to sauna_roles_url, notice: "Sauna role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sauna_role
      @sauna_role = SaunaRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sauna_role_params
      params.require(:sauna_role).permit(:name_ja)
    end
end
