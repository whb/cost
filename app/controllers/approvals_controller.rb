class ApprovalsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_expense, :except => [:index]
  def load_expense
    @expense = Expense.find(params[:expense_id])
  end

  before_filter :load_period, :expect => [:index, :destroy]
  def load_period
    @period = Period.find_by_year(2013)
  end

  # GET /approvals
  # GET /approvals.json
  def index
    @expenses = Expense.approvalling.find_all_by_organization_id current_organization.subtree_ids

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /approvals/1
  # GET /approvals/1.json
  def show
    @approval = @expense.approvals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @approval }
    end
  end

  # GET /approvals/new
  # GET /approvals/new.json
  def new
    @approval = @expense.approvals.build
    @approval.level = :manager_approval
    @approval.manager = current_user.displayname if current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @approval }
    end
  end

  # GET /approvals/1/edit
  def edit
    @approval = Approval.find(params[:id])
  end

  # POST /approvals
  # POST /approvals.json
  def create
    @approval = @expense.approvals.new(params[:approval])
    @approval.approve_on = Time.now

    respond_to do |format|
      begin
        @approval.commit!
        format.html { redirect_to [@expense, @approval], notice: t('Approval was successfully created.') }
        format.json { render json: @approval, status: :created, location: @approval }
      rescue ActiveRecord::RecordInvalid
        format.html { render action: "new" }
        format.json { render json: @approval.errors, status: :unprocessable_entity }
      end  
    end
  end

  # PUT /approvals/1
  # PUT /approvals/1.json
  def update
    @approval = Approval.find(params[:id])

    respond_to do |format|
      if @approval.update_attributes(params[:approval])
        format.html { redirect_to @approval, notice: t('Approval was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /approvals/1
  # DELETE /approvals/1.json
  def destroy
    @approval = Approval.find(params[:id])
    @approval.destroy

    respond_to do |format|
      format.html { redirect_to approvals_url }
      format.json { head :no_content }
    end
  end
end
