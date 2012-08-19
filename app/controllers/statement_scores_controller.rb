class StatementScoresController < ApplicationController
  # GET /statement_scores
  # GET /statement_scores.json
  def index
    @statement_scores = StatementScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statement_scores }
    end
  end

  # GET /statement_scores/1
  # GET /statement_scores/1.json
  def show
    @statement_score = StatementScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statement_score }
    end
  end

  # GET /statement_scores/new
  # GET /statement_scores/new.json
  def new
    @statement_score = StatementScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement_score }
    end
  end

  # GET /statement_scores/1/edit
  def edit
    @statement_score = StatementScore.find(params[:id])
  end

  # POST /statement_scores
  # POST /statement_scores.json
  def create
    @statement_score = StatementScore.new(params[:statement_score])

    respond_to do |format|
      if @statement_score.save
        format.html { redirect_to @statement_score, notice: 'Statement score was successfully created.' }
        format.json { render json: @statement_score, status: :created, location: @statement_score }
      else
        format.html { render action: "new" }
        format.json { render json: @statement_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statement_scores/1
  # PUT /statement_scores/1.json
  def update
    @statement_score = StatementScore.find(params[:id])

    respond_to do |format|
      if @statement_score.update_attributes(params[:statement_score])
        format.html { redirect_to @statement_score, notice: 'Statement score was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statement_scores/1
  # DELETE /statement_scores/1.json
  def destroy
    @statement_score = StatementScore.find(params[:id])
    @statement_score.destroy

    respond_to do |format|
      format.html { redirect_to statement_scores_url }
      format.json { head :ok }
    end
  end
end
