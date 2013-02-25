class CostNamesController < ApplicationController
  skip_authorization_check

  # GET /cost_names/lookup?q=xx (default: json)
  def lookup
    @cost_names = Item.select("DISTINCT name").where("name like ?", "%#{params[:q]}%").limit(20).map(&:name)
    @cost_names += Detail.select("DISTINCT name").where("name like ?", "%#{params[:q]}%").limit(20).map(&:name)
    @cost_names = @cost_names.uniq
    respond_to do |format|
      format.json { render json: @cost_names }
    end
  end
end
