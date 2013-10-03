class PoliticalPartiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :admin)
  end

  # GET /political_parties
  # GET /political_parties.json
  def index
    @political_parties = PoliticalParty.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @political_parties }
    end
  end

  # GET /political_parties/1
  # GET /political_parties/1.json
  def show
    @political_party = PoliticalParty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @political_party }
    end
  end

  # GET /political_parties/new
  # GET /political_parties/new.json
  def new
    @political_party = PoliticalParty.new
    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@political_party.political_party_translations.build(:locale => locale.to_s)
		end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @political_party }
    end
  end

  # GET /political_parties/1/edit
  def edit
    @political_party = PoliticalParty.find(params[:id])
  end

  # POST /political_parties
  # POST /political_parties.json
  def create
    @political_party = PoliticalParty.new(params[:political_party])

    add_missing_translation_content(@political_party.political_party_translations)

    respond_to do |format|
      if @political_party.save
        format.html { redirect_to political_parties_path, notice: t('app.msgs.success_created', :obj => t('app.common.political_party')) }
        format.json { render json: @political_party, status: :created, location: @political_party }
      else
        format.html { render action: "new" }
        format.json { render json: @political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /political_parties/1
  # PUT /political_parties/1.json
  def update
    @political_party = PoliticalParty.find(params[:id])

    @political_party.assign_attributes(params[:political_party])

    add_missing_translation_content(@political_party.political_party_translations)
    
    respond_to do |format|
      if @political_party.save
        format.html { redirect_to political_parties_path, notice: t('app.msgs.success_updated', :obj => t('app.common.political_party')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @political_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /political_parties/1
  # DELETE /political_parties/1.json
  def destroy
    PoliticalParty.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to political_parties_url }
      format.json { head :ok }
    end
  end
end
