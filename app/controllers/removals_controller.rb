class RemovalsController < ApplicationController
  def question
    binding.pry
    @review = Review.find(params[:id])
    @question = Question.find_by(id: question.id)
    @question.review_id = nil
    binding.pry
    @question.save
    redirect_to user_review_path(current_user, @review)
  end
end
