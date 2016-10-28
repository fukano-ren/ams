class PasschenController < ApplicationController
  def index
  end

  def update
    respond_to do |format|
      if current_user.update_with_password(user_params)
        sign_in(current_user, bypass: true)
        format.html {redirect_to edit_passchen_pass}
      else
        format.html{ render :edit}
      end 
    end
  end
end
