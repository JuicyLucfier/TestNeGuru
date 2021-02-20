class TestsController < ApplicationController

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def start
    @test = Test.find(params[:id])
    if @test.questions.count.positive?
      current_user.tests.push(@test)
      redirect_to current_user.test_passage(@test)
    else
      flash[:alert] = t('no_questions')
      redirect_to tests_path
    end
  end

  private

  def rescue_with_test_not_found
    render plain: 'Test was not found!'
  end

end
