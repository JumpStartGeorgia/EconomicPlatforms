class CategoryController < ApplicationController

	def index
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else

	    @statements = Statement.by_economic_category(@economic_category.id)

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
	end

	def statement
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  @statements = Statement.by_economic_category(@economic_category.id).where(:id => params[:id])
			@statement = @statements.first if @statements && !@statements.empty?

			if !@statement
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
				end
			end
		end
	end
end
