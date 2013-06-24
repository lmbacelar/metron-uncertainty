class ModelsController < ApplicationController

  helper_method :model, :recent_models, :variables

  def index
  end

  def show
  end

  protected

  def model
    Model.find_by! url: params[:id]
  end

  def recent_models
    Model.recent
  end

  def variables
    model.variables
  end
end
