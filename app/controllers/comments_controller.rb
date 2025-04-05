class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to spoiler_review_path(comment.review), success: t("defaults.flash_message.created", item: Comment.model_name.human)
    else
      redirect_to spoiler_review_path(comment.review), danger: t("defaults.flash_message.not_created", item: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(review_id: params[:review_id])
  end
end
