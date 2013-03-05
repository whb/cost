class DetailsController < ApplicationController
  skip_authorization_check
  def query
    @category = Category.find(params[:category_id]) if (params[:category_id])
    @organization = Organization.find(params[:organization_id]) if (params[:organization_id])
    @month = params[:month] if (params[:month])
  end
end
