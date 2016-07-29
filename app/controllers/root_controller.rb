class RootController < ApplicationController

  def index

		# get the latest statements
		@statements = Statement.sorted.published.latest.by_election(@current_election_id)

    @activities = Activity.sorted.by_election(@current_election_id)

		gon.highlight_first_form_field = false
		
		# see if banner for this election exists, if not load default
		# @banner_img_name = "banner_#{@current_election_id}.jpg"
		# @banner_img_name = "banner.jpg" if Rails.application.assets.find_asset(@banner_img_name).blank?
		@banner_img_name = "banner.jpg"

    # see if policy briefs exist
    @policy_briefs_count = PolicyBrief.by_election(@current_election_id).published.count
  end

	def search
	end

	def sitemap
		  @activities = Activity.sorted.by_election(@current_election_id)
	end


	def charts
    # get the ideological values for each economic category
    ideological_id = 5
    @values = []
    @div_id_prefix = "ec_chart_"
    @economic_categories_nav.each do |ec_cat|
      data = Platform.scores_for_ec_cat_and_ind_cat(@current_election_id, ec_cat.id,ideological_id)
      if data.present?
        @values << {:div_id => "#{@div_id_prefix}#{ec_cat.id}", :name => ec_cat.name, :data => data.map{|x| x.scores_to_hash}}
      end
    end

    if @values.present?
      # get indicators for this category
      @indicators = Indicator.sorted.by_indicator_category(ideological_id).sort{|a,b| b.value <=> a.value}

      # load a gon variable with the data for the chart
      gon.economic_chart_data = @values
      gon.number_parties = @political_parties_nav.length
			gon.direction_left = t("app.scales.indicator_category_id_#{ideological_id}.top")
			gon.direction_center = t("app.scales.indicator_category_id_#{ideological_id}.middle")
			gon.direction_right = t("app.scales.indicator_category_id_#{ideological_id}.bottom")
    end
	end

	def about
		@page = Page.find_by_name('about')
	end

	def methodology
		@page = Page.find_by_name('methodology')
	end

end
