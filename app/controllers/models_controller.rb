class ModelsController < ApplicationController

  helper_method :recent_models

  def index
  end

  protected

  def recent_models
    Model.recent
  end
end
