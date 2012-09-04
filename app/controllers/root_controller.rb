class RootController < ApplicationController

  def index
    # get the ideological values for each economic category
    ideological_id = 5
    @values = []
    @div_id_prefix = "ec_chart_"
    @economic_categories_nav.each do |ec_cat|
      data = Platform.scores_for_ec_cat_and_ind_cat(ec_cat.id,ideological_id)
      if data && !data.empty?
        @values << {:div_id => "#{@div_id_prefix}#{ec_cat.id}", :name => ec_cat.name, :data => data.map{|x| x.scores_to_hash}}
      end
    end

    if @values && !@values.empty?
      # get indicators for this category
      @indicators = Indicator.by_indicator_category(ideological_id)

      # load a gon variable with the data for the chart
      gon.economic_chart_data = @values
      gon.number_parties = @political_parties_nav.length
    end

  end

	def about
		@page = Page.find_by_name('about')
	end

end
