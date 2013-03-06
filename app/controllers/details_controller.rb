class DetailsController < ApplicationController
  skip_authorization_check
  def query
    @category = Category.find(params[:category_id]) if (params[:category_id])
    @organization = Organization.find(params[:organization_id]) if (params[:organization_id])
    @month = params[:month] if (params[:month])

    if @month == '*'
      @details = Detail.committed.this_year.
        belongs_to_category(@category.id).belongs_to_organization(@organization.id)
    else
      @month = @month.to_i
      @details = Detail.committed.interval(begin_to_end_of(@month)).
        belongs_to_category(@category.id).belongs_to_organization(@organization.id)
    end
  end
end
