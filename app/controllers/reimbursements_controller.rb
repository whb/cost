class ReimbursementsController < ApplicationController
  layout 'main_with_sidebar', :except => [:index, :query, :query_expenses, :list_verify]

  load_and_authorize_resource
  before_filter :remember_last_collections_url

  def remember_last_collections_url
    last_collections_url = request.env['HTTP_REFERER'] || reimbursements_url
    if [reimbursements_url, query_reimbursements_url, list_verify_reimbursements_url].include? last_collections_url
      session[:last_reimbursement_collection_url] = last_collections_url
    end
  end

  def users_browser_is_new_version
    user_agent_string = request.env['HTTP_USER_AGENT'] 
    user_agent = UserAgent.parse(user_agent_string)
    return true if user_agent.browser.downcase == "chrome" && Gem::Version.new(user_agent.version) > Gem::Version.new('40.0.0.0')
    return false
  end

  # GET /reimbursements
  # GET /reimbursements.json
  def index
    @reimbursements = Reimbursement.activing.find_all_by_organization_id current_organization.subtree_ids

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reimbursements }
    end
  end

  def query
    if current_user.is?(:general_manager) || current_user.is?(:financial_officer)
      @reimbursements = Reimbursement.all
    elsif current_user.is?(:vice_manager)
      @reimbursements = Reimbursement.find_all_by_organization_id current_user.related_organizations_id
    else
      @reimbursements = Reimbursement.find_all_by_organization_id current_organization.subtree_ids
    end

    respond_to do |format|
      format.html # query.html.erb
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

  def list_verify
    @reimbursements = Reimbursement.activing

    respond_to do |format|
      format.html # list_verify.html.erb
      format.json { render json: @reimbursements }
    end
  end

  # GET /reimbursements/1
  # GET /reimbursements/1.json
  # GET /reimbursements/1.pdf
  def show
    @reimbursement = Reimbursement.find(params[:id])

    if users_browser_is_new_version
      @new_version_chrome = true
      @fixed_a4_margin = 0
    else
      @fixed_a4_margin = 53
      @fixed_a4_margin = 0 unless params[:left].blank?
      @fixed_a4_margin = 104 unless params[:right].blank?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reimbursement }
      format.pdf { render :layout => false }
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

  def generate_sn
    sn = Reimbursement.generate_sn
    respond_to do |format|
      format.json { render json: sn}
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

    respond_to do |format|
      begin
        @reimbursement.commit!
        format.html { redirect_to @reimbursement, notice: t('Reimbursement was successfully committed.') }
        format.json { head :no_content }
      rescue ActiveRecord::RecordInvalid
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
