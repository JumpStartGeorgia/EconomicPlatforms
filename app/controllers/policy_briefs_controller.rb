class PolicyBriefsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end

  # GET /policy_briefs
  # GET /policy_briefs.json
  def index
    @policy_briefs = PolicyBrief.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @policy_briefs }
    end
  end

  # GET /policy_briefs/1
  # GET /policy_briefs/1.json
  def show
    @policy_brief = PolicyBrief.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @policy_brief }
    end
  end

  # GET /policy_briefs/new
  # GET /policy_briefs/new.json
  def new
    @policy_brief = PolicyBrief.new
    @indicator_categories = IndicatorCategory.with_indicators

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@policy_brief.policy_brief_translations.build(:locale => locale)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @policy_brief }
    end
  end

  # GET /policy_briefs/1/edit
  def edit
    @policy_brief = PolicyBrief.find(params[:id])
    @indicator_categories = IndicatorCategory.with_indicators
  end

  # POST /policy_briefs
  # POST /policy_briefs.json
  def create
    @policy_brief = PolicyBrief.new(params[:policy_brief])

    respond_to do |format|
      if @policy_brief.save
        format.html { redirect_to @policy_brief, notice: t('app.msgs.success_created', :obj => t('app.common.policy_brief')) }
        format.json { render json: @policy_brief, status: :created, location: @policy_brief }
      else
        @indicator_categories = IndicatorCategory.with_indicators
        format.html { render action: "new" }
        format.json { render json: @policy_brief.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /policy_briefs/1
  # PUT /policy_briefs/1.json
  def update
    @policy_brief = PolicyBrief.find(params[:id])

    respond_to do |format|
      if @policy_brief.update_attributes(params[:policy_brief])
        format.html { redirect_to @policy_brief, notice: t('app.msgs.success_updated', :obj => t('app.common.policy_brief')) }
        format.json { head :ok }
      else
        @indicator_categories = IndicatorCategory.with_indicators
        format.html { render action: "edit" }
        format.json { render json: @policy_brief.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_briefs/1
  # DELETE /policy_briefs/1.json
  def destroy
    @policy_brief = PolicyBrief.find(params[:id])
    @policy_brief.destroy

    respond_to do |format|
      format.html { redirect_to policy_briefs_url }
      format.json { head :ok }
    end
  end
end
