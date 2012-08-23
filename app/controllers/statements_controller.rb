class StatementsController < ApplicationController
  before_filter :authenticate_user!,
		:except => [:political_party, :economic_category, :political_party_show, :economic_category_show]
  before_filter :except => [:political_party, :economic_category, :political_party_show, :economic_category_show] do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end


  # GET /statements/political_party/:political_party_id
  # GET /statements/political_party/:political_party_id.json
  def political_party
		@political_party = PoliticalParty.find(params[:political_party_id])
    @statements = Statement.by_political_party(params[:political_party_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/political_party/:political_party_id/show/:id
  # GET /statements/political_party/:political_party_id/show/:id.json
  def political_party_show
		@political_party = PoliticalParty.find(params[:political_party_id])
    @statements = Statement.by_political_party(params[:political_party_id]).where(:id => params[:id])

		@statement = @statements.first if @statements && !@statements.empty?

		redirect_to root_path, notice: t('app.msgs.does_not_exist') if !@statement

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/economic_category/:economic_category_id
  # GET /statements/economic_category/:economic_category_id.json
  def economic_category
		@economic_category = EconomicCategory.find(params[:economic_category_id])
    @statements = Statement.by_economic_category(params[:economic_category_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/economic_category/:economic_category_id/:id
  # GET /statements/economic_category/:economic_category_id/:id.json
  def economic_category_show
		@economic_category = EconomicCategory.find(params[:economic_category_id])
    @statements = Statement.by_economic_category(params[:economic_category_id]).where(:id => params[:id])

		@statement = @statements.first if @statements && !@statements.empty?

		redirect_to root_path, notice: t('app.msgs.does_not_exist') if !@statement

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements
  # GET /statements.json
  def index
    @statements = Statement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
    @statement = Statement.find(params[:id])

		redirect_to root_path, notice: t('app.msgs.does_not_exist') if !@statement

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/new
  # GET /statements/new.json
  def new
    @statement = Statement.new
    @indicator_categories = IndicatorCategory.with_indicators

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.length.times {@statement.statement_translations.build}

    # create the score object for however many categories there are
    # so the form will properly create all of the nested form fields
    @indicator_categories.length.times {@statement.statement_scores.build}

		# turn the datetime picker js on
		# have to format dates this way so js datetime picker read them properly
		gon.edit_statement = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/1/edit
  def edit
    @statement = Statement.find(params[:id])
    @indicator_categories = IndicatorCategory.with_indicators
		# turn the datetime picker js on
		# have to format dates this way so js datetime picker read them properly
		gon.edit_statement = true
		gon.date_made = @statement.date_made.strftime('%m/%d/%Y') if !@statement.date_made.nil?
  end

  # POST /statements
  # POST /statements.json
  def create
    # split the score values into indicator_id and value
    params[:statement][:statement_scores_attributes].each do |key, values|
      # [indicator_id, value]
      combined = values[:combined].split("||")
      values[:indicator_id] = combined[0]
      values[:value] = combined[1]
    end
    @statement = Statement.new(params[:statement])

    respond_to do |format|
      if @statement.save
        format.html { redirect_to @statement, notice: 'Statement was successfully created.' }
        format.json { render json: @statement, status: :created, location: @statement }
      else
    		# turn the datetime picker js on
    		# have to format dates this way so js datetime picker read them properly
    		gon.edit_statement = true
    		gon.date_made = @statement.date_made.strftime('%m/%d/%Y') if !@statement.date_made.nil?
        @indicator_categories = IndicatorCategory.with_indicators
        format.html { render action: "new" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statements/1
  # PUT /statements/1.json
  def update
    # split the score values into indicator_id and value
    params[:statement][:statement_scores_attributes].each do |key, values|
      # [indicator_id, value]
      combined = values[:combined].split("||")
      values[:indicator_id] = combined[0]
      values[:value] = combined[1]
    end
    @statement = Statement.find(params[:id])

    respond_to do |format|
      if @statement.update_attributes(params[:statement])
        format.html { redirect_to @statement, notice: 'Statement was successfully updated.' }
        format.json { head :ok }
      else
    		# turn the datetime picker js on
    		# have to format dates this way so js datetime picker read them properly
    		gon.edit_statement = true
    		gon.date_made = @statement.date_made.strftime('%m/%d/%Y') if !@statement.date_made.nil?
        @indicator_categories = IndicatorCategory.with_indicators
        format.html { render action: "edit" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement = Statement.find(params[:id])
    @statement.destroy

    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :ok }
    end
  end
end
