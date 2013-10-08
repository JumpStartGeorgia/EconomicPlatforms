class ActivitiesController < ApplicationController
	use_tinymce :create, :update, :new, :edit

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter(:except => [:show, :index]) do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end

  # GET /activities
  # GET /activities.json
  def index
		if user_signed_in?
		  @activities = Activity.sorted.by_election(@current_election_id)

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @activities }
		  end
		else
			redirect_to formatted_root_path
		end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activities = Activity.sorted.by_election(@current_election_id)
    @activity = @activities.select{|x| x.id.to_s == params[:id]}
		if @activity.present?
			@activity = @activity.first
		else
			@activity = nil
		end

    if @activity.blank?
			redirect_to formatted_root_path, notice: t('app.msgs.does_not_exist')
    else
      if @activity && @activity.images.length > 0
        @load_image_slider = true
        gon.slider_images = []
        @activity.images.each do |img|
          gon.slider_images << {"img_src" => img.file.url(:medium)}
        end
      end

		  @statements = Statement.sorted.published.latest.by_election(@current_election_id)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @activity }
      end
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@activity.activity_translations.build(:locale => locale.to_s)
		end

		gon.edit_activity = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
		gon.edit_activity = true
		gon.activity_date = @activity.date.strftime('%m/%d/%Y') if !@activity.date.nil?
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    add_missing_translation_content(@activity.activity_translations)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: t('app.msgs.success_created', :obj => t('app.common.activity')) }
        format.json { render json: @activity, status: :created, location: @activity }
      else
				gon.edit_activity = true
				gon.activity_date = @activity.date.strftime('%m/%d/%Y') if !@activity.date.nil?
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    @activity.assign_attributes(params[:activity])

    add_missing_translation_content(@activity.activity_translations)
    
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: t('app.msgs.success_updated', :obj => t('app.common.activity')) }
        format.json { head :ok }
      else
				gon.edit_activity = true
				gon.activity_date = @activity.date.strftime('%m/%d/%Y') if !@activity.date.nil?
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    Activity.delete_hack(params[:id])

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end
end
