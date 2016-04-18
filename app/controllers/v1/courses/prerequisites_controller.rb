class V1::Courses::PrerequisitesController < ApplicationController
  def index
    @course = Course.find(params[:id])
    @prerequisites = @course.prerequisites(rel_length: :any)
  end

  def show
    @course = Course.find(params[:id])
    @prerequisites = @course.prerequisites
  end
end
