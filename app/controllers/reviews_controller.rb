class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @review.questions.build
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Review Questionaire Created"
      redirect_to user_taxis_path(current_user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
    @review = Review.find(params[:id])
    @questions = @review.questions.load
  end

  def index
    @reviews = Review.all
  end

  def destroy
  end

  private

    def review_params
      params.require(:review).permit(:name, questions_attributes: [:id, :content, :answer_type])
    end

end
