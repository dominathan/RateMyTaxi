class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @review.questions.build
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:success] = "Review Questionaire Created"
      redirect_to reviews_path
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
    @questions = @review.questions.all
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
