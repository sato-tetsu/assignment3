class BooksController < ApplicationController
    before_action :authenticate_user!  #ログインしていない場合、ログイン画面へリダイレクト

    
	def new
		@book = Book.new
    end

    def create
    	@book = Book.new(book_params)
        @book.user_id = current_user.id
        
        if @book.save
    	   redirect_to books_path
        else
            flash[:alert1] = @book.errors.full_messages
            render :index
        end
    end

    def index
        @user = current_user
        @books = Book.page(params[:page]).reverse_order
        @book = Book.new
    end

    def show
        @books = Book.find(params[:id])
        @user =  @books.user
        @book = Book.new
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        book = Book.find(params[:id])
        book.update(book_params)
        redirect_to book_path(book)
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

private
    def book_params
        params.require(:book).permit(:title, :body)
    end

end
