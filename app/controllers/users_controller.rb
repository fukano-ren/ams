class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_password, :update_password]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def zen_edit
    @users = User.all
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


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '削除しました' }
      format.json { head :no_content }
    end
  end

 
 def search 
   @users = Users.where(code: params["search"]["code"])
   @users = Users.where(name: params["search"]["name"]) 
   @users = Users.where(department_id: params["search"]["department_id"])
   render :index
 end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:code, :name, :password, :department_id, :system, :admin, :updated_at, :created_at, :password_confirmation)
    end
    def auth
      code = 'fukano-ren'
      passwd = 'Tamadou0526'
      authenticate_or_request_with_http_basic('Asm') do |c,p|
        c == code && p == passwd
      end
    end
end
