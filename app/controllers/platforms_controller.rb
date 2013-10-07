class PlatformsController < ApplicationController
	use_tinymce :create, :update, :new, :edit

  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end

  # GET /platforms
  # GET /platforms.json
  def index
	  @platforms = Platform.by_election(@current_election_id).sort_by{|x| [x.political_party.name, x.economic_category.name]}.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @platforms }
    end
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
    @platform = Platform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/new
  # GET /platforms/new.json
  def new
    @platform = Platform.new
    @indicator_categories = IndicatorCategory.with_indicators.sorted

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@platform.platform_translations.build(:locale => locale.to_s)
		end

    gon.election_political_parties_path = election_political_parties_path(:election_id => 999)

    # create the score object for however many categories there are
    # so the form will properly create all of the nested form fields
    @indicator_categories.each do |cat|
			@platform.platform_scores.build(:indicator_category_id => cat.id)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/1/edit
  def edit
    @platform = Platform.find(params[:id])
    @indicator_categories = IndicatorCategory.with_indicators.sorted

    gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
  end

  # POST /platforms
  # POST /platforms.json
  def create
    # split the score values into indicator_id and value
    params[:platform][:platform_scores_attributes].each do |key, values|
      # [indicator_id, value]
			if values[:combined] && !values[:combined].empty?
		    combined = values[:combined].split("||")
		    values[:indicator_id] = combined[0]
		    values[:value] = combined[1]
			end
    end

    @platform = Platform.new(params[:platform])

    add_missing_translation_content(@platform.platform_translations)

    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: t('app.msgs.success_created', :obj => t('app.common.platform')) }
        format.json { render json: @platform, status: :created, location: @platform }
      else
		    @indicator_categories = IndicatorCategory.with_indicators.sorted
        gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
        format.html { render action: "new" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /platforms/1
  # PUT /platforms/1.json
  def update
    params[:platform][:platform_scores_attributes].each do |key, values|
      # [indicator_id, value]
			if values[:combined] && !values[:combined].empty?
		    combined = values[:combined].split("||")
		    values[:indicator_id] = combined[0]
		    values[:value] = combined[1]
			end
    end
    
    @platform = Platform.find(params[:id])

    @platform.assign_attributes(params[:platform])

    add_missing_translation_content(@platform.platform_translations)
    
    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: t('app.msgs.success_created', :obj => t('app.common.platform')) }
        format.json { head :ok }
      else
		    @indicator_categories = IndicatorCategory.with_indicators.sorted
        gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
        format.html { render action: "edit" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    Platform.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to platforms_url }
      format.json { head :ok }
    end
  end
end
