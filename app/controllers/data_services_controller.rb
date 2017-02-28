class DataServicesController < ApplicationController
  def index
    @services = DataMicroservice.all
  end

  def new
    @service = DataMicroservice.new
    @datasource = Datasource.where(state: true)
    @tables = []
  end

  def update_tables
    d = Datasource.find(params[:datasource_id])
    if d
    @tables = d.tables
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @service = DataMicroservice.new(dataservice_params)
    @datasource = Datasource.where(state: true)
    @tables = []
    if @service.save!
      redirect_to data_services_path, flash: {notice: "Success!"}
    else
      flash.now[:alert] = 'There was an error'
      render :new
    end
  end

  def update
  end

  def destroy
    dts = DataMicroservice.find(params[:id])
    if dts and dts.destroy
      redirect_to data_services_path, flash: {success: "success destroy!"}
    else
      redirect_to data_services_path, flash: {alert: "was a error"}
    end
  end

  private
  def dataservice_params
    params.require(:data_microservice).permit(:name, :table, :datasource_id)
  end
end
