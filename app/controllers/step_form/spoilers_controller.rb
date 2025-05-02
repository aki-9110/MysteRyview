module StepForm
  class SpoilersController < ApplicationController
    def new
      @spoiler = StepForm::Spoiler.new
    end
  end
end