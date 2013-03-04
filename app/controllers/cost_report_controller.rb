class CostReportController < ApplicationController
  skip_authorization_check

  def organization_months
    @organization_amount_hash = {}

    Organization.all.each do | o |
      @organization_amount_hash[o] = []

      1.upto(12).each do | month |
        begin_date = Date.new(Date.today.year , month, 1)
        if (month == 12)
          end_date = Date.new(Date.today.year+1 , 1, 1)
        else
          end_date = Date.new(Date.today.year , month+1, 1)
        end
        sum_amount = Reimbursement.where({:reimburse_on => begin_date...end_date, :organization_id => o.id}).sum(:amount)

        @organization_amount_hash[o][month] = sum_amount
      end
    end
  end

  def category_months
    @category_amount_hash = {}

    Category.all.each do | c |
      @category_amount_hash[c] = []

      1.upto(12).each do | month |
        begin_date = Date.new(Date.today.year , month, 1)
        if (month == 12)
          end_date = Date.new(Date.today.year+1 , 1, 1)
        else
          end_date = Date.new(Date.today.year , month+1, 1)
        end

        sum_amount = Reimbursement.where({:reimburse_on => begin_date...end_date}).sum(:amount)

        @category_amount_hash[c][month] = sum_amount
      end
    end
    
  end
end
