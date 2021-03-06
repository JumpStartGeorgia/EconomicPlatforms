class ElectionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /elections
  # GET /elections.json
  def index
	  @elections = Election.all

	  respond_to do |format|
	    format.html # index.html.erb
	    format.json { render json: @elections }
	  end
  end

  # GET /elections/1
  # GET /elections/1.json
  def show
    @election = Election.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @election }
    end
  end

  # GET /elections/new
  # GET /elections/new.json
  def new
    @election = Election.new

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			et = @election.election_translations.build(:locale => locale.to_s)
      et.build_report_file
		end

    gon.edit_election = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @election }
    end
  end

  # GET /elections/1/edit
  def edit
    @election = Election.find(params[:id])

    # if the translation does not have a report file, build it 
    # so it is available in the form
    @election.election_translations.each do |et|
      et.build_report_file if et.report_file.nil?
    end

    gon.edit_election = true
		@election.date = @election.date.strftime('%d.%m.%Y') if !@election.date.nil?
  end

  # POST /elections
  # POST /elections.json
  def create
    @election = Election.new(params[:election])

    add_missing_translation_content(@election.election_translations)
    
    respond_to do |format|
      if @election.save
        format.html { redirect_to @election, notice: t('app.msgs.success_created', :obj => t('app.common.election')) }
        format.json { render json: @election, status: :created, location: @election }
      else
        format.html { render action: "new" }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elections/1
  # PUT /elections/1.json
  def update
    @election = Election.find(params[:id])

    @election.assign_attributes(params[:election])

    add_missing_translation_content(@election.election_translations)
    
    respond_to do |format|
      if @election.save
        format.html { redirect_to @election, notice: t('app.msgs.success_updated', :obj => t('app.common.election')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elections/1
  # DELETE /elections/1.json
  def destroy
    Election.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to elections_url }
      format.json { head :ok }
    end
  end






  def political_parties
    @political_parties = PoliticalParty.by_election(params[:election_id]).sorted
    respond_to do |format|
      format.html { render partial: 'political_parties' }
    end
  end


end
