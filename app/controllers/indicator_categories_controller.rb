class IndicatorCategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /indicator_categories
  # GET /indicator_categories.json
  def index
    @indicator_categories = IndicatorCategory.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @indicator_categories }
    end
  end

  # GET /indicator_categories/1
  # GET /indicator_categories/1.json
  def show
    @indicator_category = IndicatorCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @indicator_category }
    end
  end

  # GET /indicator_categories/new
  # GET /indicator_categories/new.json
  def new
    @indicator_category = IndicatorCategory.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@indicator_category.indicator_category_translations.build(:locale => locale.to_s)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @indicator_category }
    end
  end

  # GET /indicator_categories/1/edit
  def edit
    @indicator_category = IndicatorCategory.find(params[:id])
  end

  # POST /indicator_categories
  # POST /indicator_categories.json
  def create
    @indicator_category = IndicatorCategory.new(params[:indicator_category])

    add_missing_translation_content(@indicator_category.indicator_category_translations)

    respond_to do |format|
      if @indicator_category.save
        format.html { redirect_to @indicator_category, notice: t('app.msgs.success_created', :obj => t('app.common.indicator_category')) }
        format.json { render json: @indicator_category, status: :created, location: @indicator_category }
      else
        format.html { render action: "new" }
        format.json { render json: @indicator_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /indicator_categories/1
  # PUT /indicator_categories/1.json
  def update
    @indicator_category = IndicatorCategory.find(params[:id])

    @indicator_category.assign_attributes(params[:indicator_category])

    add_missing_translation_content(@indicator_category.indicator_category_translations)
    
    respond_to do |format|
      if @indicator_category.save
        format.html { redirect_to @indicator_category, notice: t('app.msgs.success_updated', :obj => t('app.common.indicator_category')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @indicator_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicator_categories/1
  # DELETE /indicator_categories/1.json
  def destroy
    IndicatorCategory.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to indicator_categories_url }
      format.json { head :ok }
    end
  end
end
