class MajorCategoriesController < ApplicationController
  load_and_authorize_resource
  # GET /major_categories
  # GET /major_categories.json
  def index
    @major_categories = MajorCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @major_categories }
    end
  end

  # GET /major_categories/1
  # GET /major_categories/1.json
  def show
    @major_category = MajorCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @major_category }
    end
  end

  # GET /major_categories/new
  # GET /major_categories/new.json
  def new
    @major_category = MajorCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @major_category }
    end
  end

  # GET /major_categories/1/edit
  def edit
    @major_category = MajorCategory.find(params[:id])
  end

  # POST /major_categories
  # POST /major_categories.json
  def create
    @major_category = MajorCategory.new(params[:major_category])

    respond_to do |format|
      if @major_category.save
        format.html { redirect_to @major_category, notice: 'Major category was successfully created.' }
        format.json { render json: @major_category, status: :created, location: @major_category }
      else
        format.html { render action: "new" }
        format.json { render json: @major_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /major_categories/1
  # PUT /major_categories/1.json
  def update
    @major_category = MajorCategory.find(params[:id])

    respond_to do |format|
      if @major_category.update_attributes(params[:major_category])
        format.html { redirect_to @major_category, notice: 'Major category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @major_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /major_categories/1
  # DELETE /major_categories/1.json
  def destroy
    @major_category = MajorCategory.find(params[:id])
    @major_category.destroy

    respond_to do |format|
      format.html { redirect_to major_categories_url }
      format.json { head :no_content }
    end
  end
end
