class UsersController < ApplicationController
  before_action :authenticate_user!    #ログインしていない場合、ログイン画面へリダイレクト

  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order
  end

  def index
    @user = current_user                    #追加しました。　User.find(params[:id])でOK?
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
      @user = User.find(params[:id])

      if @user.id != current_user.id
        redirect_to user_path(current_user.id)
      end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      flash[:alert2] = @user.errors.full_messages
      render :edit
    end
  end


  private 
	def user_params
	    params.require(:user).permit(:name, :introduction, :profile_image)
	end
  
end
