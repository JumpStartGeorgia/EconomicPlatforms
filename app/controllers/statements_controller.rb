class StatementsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]

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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/new
  # GET /statements/new.json
  def new
    @statement = Statement.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.length.times {@statement.statement_translations.build}
    
    @indicator_categories = IndicatorCategory.ordered

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
		# turn the datetime picker js on
		# have to format dates this way so js datetime picker read them properly
		gon.edit_statement = true
		gon.date_made = @statement.date_made.strftime('%m/%d/%Y') if !@statement.date_made.nil?
  end

  # POST /statements
  # POST /statements.json
  def create
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
        format.html { render action: "new" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statements/1
  # PUT /statements/1.json
  def update
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
