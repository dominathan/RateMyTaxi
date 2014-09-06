class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Review Questionaire Created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update

  def show
  end

  def index
  end

  def destroy
  end

  private

    def review_params
      params.require(:review).permit(:name, questions_attributes: [:id, :content, :answer_type])
    end
  end

end
