class IndicatorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /indicators
  # GET /indicators.json
  def index
    @indicators = Indicator.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @indicators }
    end
  end

  # GET /indicators/1
  # GET /indicators/1.json
  def show
    @indicator = Indicator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @indicator }
    end
  end

  # GET /indicators/new
  # GET /indicators/new.json
  def new
    @indicator = Indicator.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@indicator.indicator_translations.build(:locale => locale.to_s)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @indicator }
    end
  end

  # GET /indicators/1/edit
  def edit
    @indicator = Indicator.find(params[:id])
  end

  # POST /indicators
  # POST /indicators.json
  def create
    @indicator = Indicator.new(params[:indicator])

    add_missing_translation_content(@indicator.indicator_translations)

    respond_to do |format|
      if @indicator.save
        format.html { redirect_to @indicator, notice: t('app.msgs.success_created', :obj => t('app.common.indicator')) }
        format.json { render json: @indicator, status: :created, location: @indicator }
      else
        format.html { render action: "new" }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /indicators/1
  # PUT /indicators/1.json
  def update
    @indicator = Indicator.find(params[:id])

    @indicator.assign_attributes(params[:indicator])

    add_missing_translation_content(@indicator.indicator_translations)
    
    respond_to do |format|
      if @indicator.save
        format.html { redirect_to @indicator, notice: t('app.msgs.success_updated', :obj => t('app.common.indicator')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicators/1
  # DELETE /indicators/1.json
  def destroy
    Indicator.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to indicators_url }
      format.json { head :ok }
    end
  end
end
