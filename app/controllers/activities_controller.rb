class ActivitiesController < ApplicationController
	use_tinymce :new, :edit

  before_filter :authenticate_user!
  before_filter do |controller_instance|
    controller_instance.send(:valid_role?, :author)
  end

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    if @activity.images.length > 0
      @load_image_slider = true
      gon.slider_images = []
      @activity.images.each do |img|
        gon.slider_images << {"img_src" => img.file.url}
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    # create the translation object for however many locales there are
    # so the form will properly create all of the nested form fields
    I18n.available_locales.each do |locale|
			@activity.activity_translations.build(:locale => locale)
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
		# if english is empty, load georgian into it
    en = params[:activity][:activity_translations_attributes].select{|k,v| v[:locale] == 'en'}
		ka = params[:activity][:activity_translations_attributes].select{|k,v| v[:locale] == 'ka'}
		if en[en.keys[0]][:locale] == 'en' && en[en.keys[0]][:title].empty?
			en[en.keys[0]][:title] = ka[ka.keys[0]][:title] if ka && !ka[ka.keys[0]][:title].empty?
		end
		if en[en.keys[0]][:locale] == 'en' && en[en.keys[0]][:body].empty?
			en[en.keys[0]][:body] = ka[ka.keys[0]][:body] if ka && !ka[ka.keys[0]][:body].empty?
		end

    @activity = Activity.new(params[:activity])

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

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
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
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end
end
