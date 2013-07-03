class ModelsController < ApplicationController

  respond_to    :html
  helper_method :model, :recent_models, :variables

  def index
  end

  def new
  end

  def create
    @model = Model.new model_params
    flash[:notice] = "Model was successfully created" if @model.save
    respond_with @model
  end

  def show
  end

  protected

  def model
    params[:id] ? Model.find_by!(url: params[:id]) : Model.new
  end

  def recent_models
    Model.recent
  end

  def variables
    model.variables
  end

  def model_params
    params.require(:model).permit(:name, :description, :equation)
  end
end
