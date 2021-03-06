class BelongsController < ApplicationController
  before_action :set_belong, only: [:show, :edit, :update, :destroy]

  # GET /belongs
  # GET /belongs.json
  def index
    @belongs = Belong.page(params[:page])
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
        format.html { redirect_to @belong, notice: '新しく登録しました' }
        format.json { render :show, status: :created, location: @belong }
      else
        format.html { render :new }
        format.json { render json: @belong.errors, status: :unprocessable_entity }
      end
    end
  end

  def copy
    @old_belong = Belong.find(params[:id])
    @belong = Belong.new
    @belong.attributes = @old_belong.attributes
    @belong.code = nil 
    @belong.memo = nil
    render :action => "new"
  end

  # PATCH/PUT /belongs/1
  # PATCH/PUT /belongs/1.json
  def update
    respond_to do |format|
      if @belong.update(belong_params)
        format.html { redirect_to @belong, notice: '登録内容を更新しました' }
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
    @belong.soft_destroy
    respond_to do |format|
      format.html { redirect_to belongs_url, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

  def search 
    @belongs = Belong.page(params[:page])
    @search_code = params["search"]["code"]
    @search_state = params["search"]["state"]
    @search_name = params["search"]["name"]
    @search_model = params["search"]["model"]
    @search_user_id = params["search"]["user_id"]
    @search_department_id = params["search"]["department_id"]
    @search_before_date = params["search"]["before_date"]
    @search_after_date = params["search"]["after_date"]
    if @search_code.present?
      @belongs = @belongs.where("code LIKE '#{@search_code}%'")
    end
    if @search_state.present?
      if @search_state == "廃棄済み"
        @belongs = @belongs.where("soft_destroyed_at not ?", nil)
      elsif @search_state == "使用中"
        @belongs = @belongs.where.not("soft_destroyed_at not ?", nil)
      end
    end
    if @search_name.present?
      @belongs = @belongs.where("name LIKE '%#{@search_name}%'")
    end
    if @search_model.present?
      @belongs = @belongs.where("model LIKE '%#{@search_model}%'")
    end
    if @search_user_id.present?
      @belongs = @belongs.where("user_id LIKE '#{@search_user_id}'")
    end
    if @search_department_id.present?
      @belongs = @belongs.where("department_id LIKE '#{@search_department_id}'")
    end
    if @search_before_date.present?
      @belongs = @belongs.where("acquired_on >= ?", Date.parse(@search_before_date))
    end
    if @search_after_date.present?
      @belongs = @belongs.where("acquired_on <= ?", Date.parse(@search_after_date))
    end

    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_belong
      @belong = Belong.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def belong_params
      params.require(:belong).permit(:code, :name, :model, :set, :department_id, :user_id, :acquired_on, :disponed_on, :memo, :delete_flg, :updated_at, :created_at)
    end
end