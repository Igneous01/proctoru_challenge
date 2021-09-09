class ExamController < ApplicationController
  def create
    RequestModel.new(params[:first_name], params[:])
  end
end
