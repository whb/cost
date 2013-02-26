class LookupController < ApplicationController
  skip_authorization_check

  # GET /lookup/cost_names?q=xx (default: json)
  def cost_names
    @cost_names = Item.select("DISTINCT name").where("name like ?", "%#{params[:q]}%").limit(20).map(&:name)
    @cost_names += Detail.select("DISTINCT name").where("name like ?", "%#{params[:q]}%").limit(20).map(&:name)
    @cost_names = @cost_names.uniq
    respond_to do |format|
      format.json { render json: @cost_names }
    end
  end

  # GET /lookup/units?q=xx (default: json)
  def units
    @units = Item.select("DISTINCT unit").where("unit like ?", "%#{params[:q]}%").limit(20).map(&:unit)
    @units += Detail.select("DISTINCT unit").where("unit like ?", "%#{params[:q]}%").limit(20).map(&:unit)
    @units = @units.uniq
    respond_to do |format|
      format.json { render json: @units }
    end
  end
end
