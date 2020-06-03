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
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end

  private 
	def user_params
	    params.require(:user).permit(:name, :introduction, :profile_image)
	end
  
end
