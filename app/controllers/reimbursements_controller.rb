class ReimbursementsController < ApplicationController
  skip_authorization_check

  before_filter :load_period, :expect => [:index, :query, :destroy]
  def load_period
    @period = Period.find_by_year(Date.today.year)
  end
  
  # GET /reimbursements
  # GET /reimbursements.json
  def index
    @reimbursements = Reimbursement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reimbursements }
    end
  end

  def query_expenses
    @expenses = Expense.waiting_reimburse.find_all_by_organization_id current_organization.subtree_ids
    @reimbursed_expenses = Expense.reimbursed.find_all_by_organization_id current_organization.subtree_ids

    respond_to do |format|
      format.html
      format.json { render json: @expenses }
    end
  end

  # GET /reimbursements/1
  # GET /reimbursements/1.json
  def show
    @reimbursement = Reimbursement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reimbursement }
    end
  end

  # GET /reimbursements/new
  # GET /reimbursements/new.json
  # GET /expenses/5/reimbursements/new
  # GET /expenses/5/reimbursements/new.json
  def new
    if params[:expense_id] == nil
      @reimbursement = Reimbursement.new_blank(current_user)
    else
      @expense = Expense.find(params[:expense_id])
      @reimbursement = Reimbursement.new_from_expense(@expense, current_user)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reimbursement }
    end
  end

  # GET /reimbursements/1/edit
  def edit
    @reimbursement = Reimbursement.find(params[:id])
  end

  def verify
    @reimbursement = Reimbursement.find(params[:id])
  end

  # POST /reimbursements
  # POST /reimbursements.json
  def create
    @reimbursement = Reimbursement.new(params[:reimbursement])
    @reimbursement.status = :edit

    respond_to do |format|
      if @reimbursement.save
        format.html { redirect_to @reimbursement, notice: t('Reimbursement was successfully created.') }
        format.json { render json: @reimbursement, status: :created, location: @reimbursement }
      else
        format.html { render action: "new" }
        format.json { render json: @reimbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reimbursements/1
  # PUT /reimbursements/1.json
  def update
    @reimbursement = Reimbursement.find(params[:id])

    respond_to do |format|
      if @reimbursement.update_attributes(params[:reimbursement])
        format.html { redirect_to @reimbursement, notice: t('Reimbursement was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reimbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  def commit
    @reimbursement = Reimbursement.find(params[:id])
    @reimbursement.status = :commit

    respond_to do |format|
      if @reimbursement.save
        format.html { redirect_to @reimbursement, notice: t('Reimbursement was successfully committed.') }
        format.json { head :no_content }
      else
        format.html { render action: "verify" }
        format.json { render json: @reimbursement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reimbursements/1
  # DELETE /reimbursements/1.json
  def destroy
    @reimbursement = Reimbursement.find(params[:id])
    @reimbursement.destroy

    respond_to do |format|
      format.html { redirect_to reimbursements_url }
      format.json { head :no_content }
    end
  end
end
