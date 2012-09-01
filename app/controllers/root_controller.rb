class RootController < ApplicationController
  before_filter :authenticate_user!, :except => [:index ]

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
    
    # if values were found, load a gon variable with the data for the chart
    if @values && !@values.empty?
      gon.economic_chart_data = @values
      gon.number_parties = @political_parties_nav.length
    end

  end

end
