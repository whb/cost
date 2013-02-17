class ReimbursementsController < ApplicationController
  skip_authorization_check
  # GET /reimbursements
  # GET /reimbursements.json
  def index
    @reimbursements = Reimbursement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reimbursements }
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
  def new
    @reimbursement = Reimbursement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reimbursement }
    end
  end

  # GET /reimbursements/1/edit
  def edit
    @reimbursement = Reimbursement.find(params[:id])
  end

  # POST /reimbursements
  # POST /reimbursements.json
  def create
    @reimbursement = Reimbursement.new(params[:reimbursement])

    respond_to do |format|
      if @reimbursement.save
        format.html { redirect_to @reimbursement, notice: 'Reimbursement was successfully created.' }
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
        format.html { redirect_to @reimbursement, notice: 'Reimbursement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
