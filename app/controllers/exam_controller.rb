require "logger"

class ExamController < ApplicationController
  def initialize 
    @dao = MockDao.new()
    @request_validator = RequestValidator.new(@dao)
    @logger = Logger.new('exam_controller.log')
  end

  def create
    @logger.info "/exam/create request received - validating"
    required_params()
    results = @request_validator.validate(params)

    if (results[0])
      @logger.info "valid request received"
      @logger.info "finding/creating user"
      if (@dao.find_user(params[:first_name], params[:last_name]).nil?)
        @logger.info "user not found - creating"
        begin
          @dao.create_user(params[:first_name], params[:last_name], params[:phone_number])
          render json: { status: "Registered successfully" }, status: :ok
        rescue Exception => e
          @logger.error "failed to create user because of an error - " + e.message
          render json: { error: "Failed to create user because of an error" }, status: :bad_request
        ensure
        end
        @logger.info "user successfully created"
      else
        @logger.info "user found"
        render json: { status: "Registered successfully" }, status: :ok
      end
    else
      @logger.error "invalid request received - " + results[1]
      render json: { error: results[1] }, status: :bad_request
    end
  end

  def required_params
    params.require(:first_name)
    params.require(:last_name)
    params.require(:phone_number)
    params.require(:college_id)
    params.require(:exam_id)
    params.require(:start_time)
  end

  rescue_from ActionController::ParameterMissing do |e|
    @logger.error "Missing parameters from request - " + e.message
    render json: { error: e.message }, status: :bad_request
  end
end
