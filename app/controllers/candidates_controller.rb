class CandidatesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.by_election(params[:election_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @candidates }
    end
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @candidate = Candidate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @candidate }
    end
  end

  # GET /candidates/new
  # GET /candidates/new.json
  def new
    @candidate = Candidate.new

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@candidate.candidate_translations.build(:locale => locale.to_s)
		end

    gon.election_political_parties_path = election_political_parties_path(:election_id => 999)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @candidate }
    end
  end

  # GET /candidates/1/edit
  def edit
    @candidate = Candidate.find(params[:id])
    gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = Candidate.new(params[:candidate])

    add_missing_translation_content(@candidate.candidate_translations)
    
    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: t('app.msgs.success_created', :obj => t('activerecord.models.candidate')) }
        format.json { render json: @candidate, status: :created, location: @candidate }
      else
        gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
        format.html { render action: "new" }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /candidates/1
  # PUT /candidates/1.json
  def update
    @candidate = Candidate.find(params[:id])

    @candidate.assign_attributes(params[:candidate])

    add_missing_translation_content(@candidate.candidate_translations)
    
    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: t('app.msgs.success_updated', :obj => t('activerecord.models.candidate')) }
        format.json { head :ok }
      else
        gon.election_political_parties_path = election_political_parties_path(:election_id => 999)
        format.html { render action: "edit" }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy_hash(params[:id])

    respond_to do |format|
      format.html { redirect_to candidates_url }
      format.json { head :ok }
    end
  end
end
