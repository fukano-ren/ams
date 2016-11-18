class BelongsController < ApplicationController
  before_action :set_belong, only: [:show, :edit, :update, :destroy]

  # GET /belongs
  # GET /belongs.json
  def index
    @belongs = Belong.all
  end

  # GET /belongs/1
  # GET /belongs/1.json
  def show
  end

  # GET /belongs/new
  def new
    @belong = Belong.new
  end

  # GET /belongs/1/edit
  def edit
  end

  # POST /belongs
  # POST /belongs.json
  def create
    @belong = Belong.new(belong_params)

    respond_to do |format|
      if @belong.save
        format.html { redirect_to @belong, notice: 'Belong was successfully created.' }
        format.json { render :show, status: :created, location: @belong }
      else
        format.html { render :new }
        format.json { render json: @belong.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /belongs/1
  # PATCH/PUT /belongs/1.json
  def update
    respond_to do |format|
      if @belong.update(belong_params)
        format.html { redirect_to @belong, notice: 'Belong was successfully updated.' }
        format.json { render :show, status: :ok, location: @belong }
      else
        format.html { render :edit }
        format.json { render json: @belong.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /belongs/1
  # DELETE /belongs/1.json
  def destroy
    @belong.destroy
    respond_to do |format|
      format.html { redirect_to belongs_url, notice: 'Belong was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_belong
      @belong = Belong.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def belong_params
      params.require(:belong).permit(:code, :name, :model, :department_id, :user_id, :acquired_on, :disponed_on, :memo, :delete_flg, :update_at, :created_at)
    end
end
