class RootController < ApplicationController
  before_filter :authenticate_user!, :except => [:index ]

  def index
    @political_party_count = Statement.count_by_political_party
    @economic_category_count = Statement.count_by_economic_category
  end

end
