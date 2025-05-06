module StepForm
  class BooksController < ApplicationController
    before_action :authenticate_user!

    def new
      @book = StepForm::Book.new
    end

    def create
      @book = StepForm::Book.new(book_params)
      if @book.valid?
        session[:step_form] = {
          book_title: @book.title,
          book_author: @book.author
        }
        redirect_to new_step_form_non_spoiler_path, success: t(".success")
      else
        flash.now[:danger] = t(".danger")
        render :new, status: :unprocessable_entity
      end
    end

    private

    def book_params
      params.require(:step_form_book).permit(:title, :author)
    end
  end
end
