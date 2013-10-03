class EconomicCategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /economic_categories
  # GET /economic_categories.json
  def index
    @economic_categories = EconomicCategory.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @economic_categories }
    end
  end

  # GET /economic_categories/1
  # GET /economic_categories/1.json
  def show
    @economic_category = EconomicCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @economic_category }
    end
  end

  # GET /economic_categories/new
  # GET /economic_categories/new.json
  def new
    @economic_category = EconomicCategory.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@economic_category.economic_category_translations.build(:locale => locale.to_s)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @economic_category }
    end
  end

  # GET /economic_categories/1/edit
  def edit
    @economic_category = EconomicCategory.find(params[:id])
  end

  # POST /economic_categories
  # POST /economic_categories.json
  def create
    @economic_category = EconomicCategory.new(params[:economic_category])
    add_missing_translation_content(@economic_category.economic_category_translations)

    respond_to do |format|
      if @economic_category.save
        format.html { redirect_to @economic_category, notice: t('app.msgs.success_created', :obj => t('app.common.economic_category')) }
        format.json { render json: @economic_category, status: :created, location: @economic_category }
      else
        format.html { render action: "new" }
        format.json { render json: @economic_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /economic_categories/1
  # PUT /economic_categories/1.json
  def update
    @economic_category = EconomicCategory.find(params[:id])

    @economic_category.assign_attributes(params[:economic_category])

    add_missing_translation_content(@economic_category.economic_category_translations)
    
    respond_to do |format|
      if @economic_category.save
        format.html { redirect_to @economic_category, notice: t('app.msgs.success_updated', :obj => t('app.common.economic_category')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @economic_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /economic_categories/1
  # DELETE /economic_categories/1.json
  def destroy
    @economic_category = EconomicCategory.find(params[:id])
    @economic_category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end
end
