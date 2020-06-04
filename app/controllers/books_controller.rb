class BooksController < ApplicationController
    before_action :authenticate_user!  #ログインしていない場合、ログイン画面へリダイレクト
    before_action :correct_user, only: [:edit]


	def new
		@book = Book.new
    end

    def create
    	@book = Book.new(book_params)
        @book.user_id = current_user.id
        
        if @book.save
            flash[:notice] = "successfully"
    	   redirect_to books_path
        else
            flash[:alert1] = @book.errors.full_messages
            redirect_to books_path
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
        @book = Book.find(params[:id])
        if  @book.update(book_params)
            flash[:notice] = "successfully"
            redirect_to book_path(@book)
        else
            flash[:alert2] = @book.errors.full_messages
            render :edit                  #この記述がおかしい　はじめは　render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end


    def correct_user
        books = Book.find(params[:id])
        if current_user != books.user
            @micropost = current_user.books.find_by(id: params[:id])
            unless @micropost
                redirect_to books_path
            end
        end
    end

private
    def book_params
        params.require(:book).permit(:title, :body)
    end

end
