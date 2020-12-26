class TestsController < ApplicationController

  before_action :find_test, only: %i[show update edit destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def new
    @test = Test.new
  end

  def index
    @tests = Test.all
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found!'
  end

end
