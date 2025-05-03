module StepForm
  class SpoilersController < ApplicationController
    def new
      @spoiler = StepForm::Spoiler.new
    end

    def create
      @spoiler = StepForm::Spoiler.new(spoiler_params)
      if @spoiler.valid?
        session[:step_form].merge!({
          spoiler_text: @spoiler.spoiler_text,
          foreshadowing: @spoiler.foreshadowing
        })
        redirect_to new_step_form_additional_info_path, success: t('.success')
      end
    end

    private

    def spoiler_params
      params.require(:step_form_spoiler).permit(:spoiler_text, :foreshadowing)
    end
  end
end