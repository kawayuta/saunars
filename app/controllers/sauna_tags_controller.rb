class SaunaTagsController < ApplicationController
  before_action :set_sauna_tag, only: %i[ show edit update destroy ]

  # GET /sauna_tags or /sauna_tags.json
  def index
    @sauna_tags = SaunaTag.all
    @sauna_tag_title_uniq = SaunaTag.select(:title).distinct.limit(10).shuffle
  end

  # GET /sauna_tags/1 or /sauna_tags/1.json
  def show
  end

  # GET /sauna_tags/new
  def new
    @sauna_tag = SaunaTag.new
  end

  # GET /sauna_tags/1/edit
  def edit
  end

  # POST /sauna_tags or /sauna_tags.json
  def create
    @sauna_tag = SaunaTag.new(sauna_tag_params)

    respond_to do |format|
      if @sauna_tag.save
        format.html { redirect_to @sauna_tag, notice: "Sauna tag was successfully created." }
        format.json { render :show, status: :created, location: @sauna_tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sauna_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sauna_tags/1 or /sauna_tags/1.json
  def update
    respond_to do |format|
      if @sauna_tag.update(sauna_tag_params)
        format.html { redirect_to @sauna_tag, notice: "Sauna tag was successfully updated." }
        format.json { render :show, status: :ok, location: @sauna_tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sauna_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sauna_tags/1 or /sauna_tags/1.json
  def destroy
    @sauna_tag.destroy
    respond_to do |format|
      format.html { redirect_to sauna_tags_url, notice: "Sauna tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sauna_tag
      @sauna_tag = SaunaTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sauna_tag_params
      params.require(:sauna_tag).permit(:title)
    end
end
