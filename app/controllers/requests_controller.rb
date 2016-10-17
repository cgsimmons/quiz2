class RequestsController < ApplicationController
  def index
    @requests = Request.all
    if params[:search]
      @requests = Request.search(params[:search]).order(:created_at).page(params[:page]).per(7)
    else
      @requests = Request.order(:created_at).page(params[:page]).per(7)
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
    @departments = Request.select(:department).distinct
  end

  def create
    req_params = params.require(:request).permit(:name, :email, :department, :message)
    @request = Request.new req_params
    if @request.save
      redirect_to request_path(@request)
    else
      @departments = Request.select(:department).distinct
      render :new
    end
  end

  def edit
    @request = Request.find(params[:id])
    @departments = Request.select(:department).distinct
  end

  def update
    @request = Request.find(params[:id])
    req_params = params.require(:request).permit(:name, :email, :department, :message)
    if @request.update req_params
      redirect_to request_path(@request)
    else
      redirect :edit
    end
  end

  def update_done
    @request = Request.find(params[:id])
    params = {name: @request.name, email: @request.email, department: @request.department, message: @request.message, done: !@request.done}
    @request.update params
    redirect_to(:back)
  end

  def dstats
    @departments = Request.dstats
    for d in @departments
      p d
    end
    render :departments
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to requests_path
  end
end
