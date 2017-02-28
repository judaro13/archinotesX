class DatasourcesController < ApplicationController

  def index
    @datasources = Datasource.all
  end

  def new
    @datasource = Datasource.new
  end

  def create

    @datasource = Datasource.new(datasource_params)
    if params[:commit] != 'Create'
      if @datasource.test_connection
        flash.now[:notice] = 'Connection success'
        render :new
      else
        flash.now[:alert] = 'I can\'t connect'
        render :new
      end
    elsif @datasource.save
      redirect_to datasources_path, flash: {notice: "Success!"}
    else
      flash.now[:alert] = 'There was an error'
      render :new
    end
  end

  def update
  end

  def destroy
    dts = Datasource.find(params[:id])

    if dts and dts.destroy
      redirect_to datasources_path, flash: {success: "success destroy!"}
    else
      redirect_to datasources_path, flash: {alert: "was a error"}
    end
  end



  private
  def datasource_params
    params.require(:datasource).permit(:host, :db_name, :username,
    :password, :port, :custom_name)
  end

end
