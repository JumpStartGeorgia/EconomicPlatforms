class StatementsController < ApplicationController
  before_filter :authenticate_user!,
		:except => [:political_party, :economic_category, :political_party_show, :economic_category_show]
  before_filter :except => [:political_party, :economic_category, :political_party_show, :economic_category_show] do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end


  # GET /statements/political_party/:political_party_id
  # GET /statements/political_party/:political_party_id.json
  def political_party
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
    @statements = Statement.by_political_party(@political_party.id) if @political_party

		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
  end

  # GET /statements/political_party/:political_party_id/show/:id
  # GET /statements/political_party/:political_party_id/show/:id.json
  def political_party_show
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
    @statements = Statement.by_political_party(@political_party.id).where(:id => params[:id]) if @political_party

		@statement = @statements.first if @statements && !@statements.empty?


		if !@political_party || !@statement
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
  end

  # GET /statements/economic_category/:economic_category_id
  # GET /statements/economic_category/:economic_category_id.json
  def economic_category
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
    @statements = Statement.by_economic_category(@economic_category.id) if @economic_category

		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
  end

  # GET /statements/economic_category/:economic_category_id/:id
  # GET /statements/economic_category/:economic_category_id/:id.json
  def economic_category_show
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
    @statements = Statement.by_economic_category(@economic_category.id).where(:id => params[:id]) if @economic_category

		@statement = @statements.first if @statements && !@statements.empty?

		if !@economic_category || !@statement
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
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
    I18n.available_locales.each do |locale|
			@statement.statement_translations.build(:locale => locale)
		end

    # create the score object for however many categories there are
    # so the form will properly create all of the nested form fields
    @indicator_categories.each do |cat|
			@statement.statement_scores.build(:indicator_category_id => cat.id)
		end

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
			if values[:combined] && !values[:combined].empty?
		    combined = values[:combined].split("||")
		    values[:indicator_id] = combined[0]
		    values[:value] = combined[1]
			end
    end
    @statement = Statement.new(params[:statement])

    respond_to do |format|
      if @statement.save
        format.html { redirect_to @statement, notice: t('app.msgs.success_created', :obj => t('app.common.statement')) }
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
			if values[:combined] && !values[:combined].empty?
		    combined = values[:combined].split("||")
		    values[:indicator_id] = combined[0]
		    values[:value] = combined[1]
			end
    end
    @statement = Statement.find(params[:id])

    respond_to do |format|
      if @statement.update_attributes(params[:statement])
        format.html { redirect_to @statement, notice: t('app.msgs.success_updated', :obj => t('app.common.statement')) }
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
