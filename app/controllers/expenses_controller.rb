class ExpensesController < ApplicationController
  layout 'main_with_sidebar', :except => [:index, :query]

  load_and_authorize_resource
  before_filter :remember_last_collections_url
  before_filter :load_period, :expect => [:index, :query, :destroy]

  def remember_last_collections_url
    last_collections_url = request.env['HTTP_REFERER'] || expenses_url
    if [expenses_url, query_expenses_url, query_expenses_reimbursements_url, approvals_url].include? last_collections_url
      session[:last_expense_collection_url] = last_collections_url
    end
  end

  def load_period
    @period = Period.find_by_year(Date.today.year)
  end

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.activing.find_all_by_organization_id current_organization.subtree_ids

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  def query
    if current_user.is?(:general_manager)
      @expenses = Expense.all
    elsif current_user.is?(:vice_manager)
      @expenses = Expense.find_all_by_organization_id current_user.related_organizations_id
    else
      @expenses = Expense.find_all_by_organization_id current_organization.subtree_ids
    end

    respond_to do |format|
      format.html
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new_blank(current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  def generate_sn
    sn = Expense.generate_sn
    respond_to do |format|
      format.json { render json: sn}
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  def verify
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    @expense.status = :edit

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: t('Expense was successfully created.') }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to @expense, notice: t('Expense was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def commit
    @expense = Expense.find(params[:id])
    @expense.status = :commit

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: t('Expense was successfully committed.') }
        format.json { head :no_content }
      else
        format.html { render action: "verify" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def discard
    @expense = Expense.find(params[:id])
    @expense.status = :invalid
    @expense.save!

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end
end
