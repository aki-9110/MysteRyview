module StepForm
  class NonSpoilersController < ApplicationController
    before_action :authenticate_user!

    def new
      @non_spoiler = StepForm::NonSpoiler.new
    end

    def create
      @non_spoiler = StepForm::NonSpoiler.new(non_spoiler_params)
      if @non_spoiler.valid?
        session[:step_form].merge!({
          non_spoiler_text: @non_spoiler.non_spoiler_text
        })
        redirect_to new_step_form_spoiler_path, success: t(".success")
      else
        flash.now[:danger] = t(".danger")
        render :new, status: :unprocessable_entity
      end
    end

    private

    def non_spoiler_params
      params.require(:step_form_non_spoiler).permit(:non_spoiler_text)
    end
  end
end
