class PartyController < ApplicationController

	def index
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
	    @statements = Statement.by_political_party(@political_party.id)

			@platforms = Platform.by_political_party(@political_party.id)
			@policy_briefs = PolicyBrief.by_political_party(@political_party.id)

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
	end

	def platform
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@economic_category
			redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
		else
			@platform = Platform.by_party_category(@political_party.id, @economic_category.id)

			if !@platform
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
				end
			end
		end
	end

	def policy_brief
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@economic_category
			redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
		else
			@policy_brief = PolicyBrief.by_party_category(@political_party.id, @economic_category.id)

			if !@policy_brief
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
				end
			end
		end
	end

	def statement
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  @statements = Statement.by_political_party(@political_party.id).where(:id => params[:id])
			@statement = @statements.first if @statements && !@statements.empty?

			if !@statement
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
				end
			end
		end
	end
end
