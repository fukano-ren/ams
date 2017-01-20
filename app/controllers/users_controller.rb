class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_password, :update_password]


  # GET /users
  # GET /users.json
  def index
    @users = search_obj
  end

  def zen_edit
    @users = User.page(params[:page])
    session[:code_s] = nil
    session[:name_s] = nil
    session[:department_id_s] = nil
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def edit_password
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: '新しく登録しました' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: '登録内容を更新しました' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    if @user.password == params["gen_password"]
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to "/menu/index", notice: 'パスワードを変更しました' }
          format.json { render :show, status: :ok, location: @user }
        else 
          format.html { render :edit_password ,notice: '入力にミスがあります'}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      @user.errors.add(:base,"入力にミスがあります")
      render :edit_password
    end
  end

  def zen_update
    User.transaction do
      @users = users_params.map do |id, user_param|
        @user = User.find(id)
        @user.update_attributes!(user_param)
      end
    end
    redirect_to users_path, notice: '登録内容を更新しました'

    rescue => e
      @users = User.page(params[:page])
      render :zen_edit
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if session[:name] == @user.name
      @users = User.page(params[:page]) 
      @error = 'ログイン中のユーザーです'
      render :index
    elsif @user.admin == true && User.where(admin: true).count == 1 
      @users = User.page(params[:page]) 
      @error = '資産管理権限を持つユーザーがいなくなります'
      render :index
    elsif Belong.where(user_id: @user.id).count > 0
      @users = User.page(params[:page]) 
      @error = 'このユーザーは資産の主使用者です'
      render :index
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: '削除しました' }
        format.json { head :no_content }
      end
    end
  end
 
  def search 
    @users = search_obj
 
    render :index
  end

  def zen_search 
    @users = search_obj
    render :zen_edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :code, :name, :password, :department_id,
        :system,:admin, :password_confirmation)
    end

    def users_params
      params.permit(users: [
        :code, :name, :password,
        :department_id, :system, :admin])[:users]
    end

    def search_obj
      @users = User.page(params[:page])
      if params["sw"] == "search"
        session[:code_s] = params["search"].try(:fetch,"code")
        session[:name_s] = params["search"].try(:fetch,"name")
        session[:department_id_s] = params["search"].try(:fetch,"department_id")
     end
      if session[:code_s].present?
        @users = @users.where("code LIKE '#{session[:code_s]}%'")
      end
      if session[:name_s].present?
        @users = @users.where("name LIKE '%#{session[:name_s]}%'")
      end
      if session[:department_id_s].present?
        @users = @users.where("department_id LIKE '#{session[:department_id_s]}'")
      end
      return @users
    end

    def auth
      code = 'fukano-ren'
      passwd = 'Tamadou0526'
      authenticate_or_request_with_http_basic('Asm') do |c,p|
        c == code && p == passwd
      end
    end
end