class Web::Admin::BooksController < Web::Admin::ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.by_updated_at
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:page])
      f(:success)
      redirect_to edit_admin_book_path
    else
      f(:error)
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @book.build_image
    @book.build_e_book
  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to admin_books_path
  end

  def tagged
    if params[:tag].present?
      @books = Book.tagged_with(params[:tag])
    else
      @books = Book.scoped
    end
    @q = @books.ransack(params[:q])
    render 'index'
  end
end
