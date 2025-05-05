module StepForm
  class AdditionalInfosController < ApplicationController
    def new
      @additional_info = StepForm::AdditionalInfo.new
    end

    def create
      @additional_info = StepForm::AdditionalInfo.new(additional_info_params)
      if @additional_info.valid?
        session[:step_form].merge!({
          "rating" => @additional_info.rating.to_i,
          "image" => @additional_info.image,
          "tag_names" => @additional_info.tag_names
        })
        # ハッシュのキーを文字列からシンボルに変換
        review_params = session[:step_form].slice(
          "non_spoiler_text", "spoiler_text", "foreshadowing", "rating", "tag_names", "image", "book_title", "book_author"
        ).symbolize_keys
        @review = current_user.reviews.build_with_book(review_params)
        if @review.save
          session.delete(:step_form)
          redirect_to reviews_path, success: t('.success')
        else
          flash.now[:danger] = t('.danger')
          render :new, status: :unprocessable_entity
        end
      else
        flash.now[:danger] = t('.danger')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def additional_info_params
      params.require(:step_form_additional_info).permit(:tag_names, :image, :rating)
    end
  end
end
