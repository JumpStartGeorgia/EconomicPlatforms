class PartyController < ApplicationController

	def index
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
	    @statements = Statement.by_political_party(@political_party.id)

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
	end

	def platform

	end

	def policy_brief

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
				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
				end
			end
		end
	end
end
