class OtypesController < ApplicationController
  before_action :set_otype, only: %i[ show edit update destroy ]

  # GET /otypes or /otypes.json
  def index
    @otypes = Otype.page(params[:page])
  end

  # GET /otypes/1 or /otypes/1.json
  def show
  end

  # GET /otypes/new
  def new
    @otype = Otype.new
  end

  # GET /otypes/1/edit
  def edit
  end

  # POST /otypes or /otypes.json
  def create
    @otype = Otype.new(otype_params)

    respond_to do |format|
      if @otype.save
        format.html { redirect_to otype_url(@otype), notice: "Otype was successfully created." }
        format.json { render :show, status: :created, location: @otype }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @otype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /otypes/1 or /otypes/1.json
  def update
    respond_to do |format|
      if @otype.update(otype_params)
        format.html { redirect_to otype_url(@otype), notice: "Otype was successfully updated." }
        format.json { render :show, status: :ok, location: @otype }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @otype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /otypes/1 or /otypes/1.json
  def destroy
    @otype.destroy

    respond_to do |format|
      format.html { redirect_to otypes_url, notice: "Otype was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_otype
      @otype = Otype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def otype_params
      params.require(:otype).permit(:title)
    end
end
