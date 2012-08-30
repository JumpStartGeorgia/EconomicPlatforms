class CategoryController < ApplicationController

	def index
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
	    @statements = Statement.by_economic_category(@economic_category.id).paginate(:page => params[:page])

			@platforms = Platform.by_economic_category(@economic_category.id)
			@policy_briefs = PolicyBrief.by_economic_category(@economic_category.id)

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
	end

	def platform
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@political_party
			redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
		else
			@platform = Platform.by_party_category(@political_party.id, @economic_category.id)

			if !@platform
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.by_economic_category(@economic_category.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "platform.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@economic_category.name} #{t('category.platform.secondary_title', :political_party => @political_party.name)}"
						filename << " #{I18n.l Time.now, :format => :file}"
						send_data(kit.to_pdf, :filename => "#{clean_string(Utf8Converter.convert_ka_to_en(filename))}.pdf", :type => 'application/pdf')
						return # to avoid double render call
					}
				end
			end
		end
	end

	def policy_brief
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@political_party
			redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
		else
			@policy_brief = PolicyBrief.by_party_category(@political_party.id, @economic_category.id)

			if !@policy_brief
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.by_economic_category(@economic_category.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "policy_brief.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@economic_category.name} #{t('category.policy_brief.secondary_title', :political_party => @political_party.name)}"
						filename << " #{I18n.l Time.now, :format => :file}"
						send_data(kit.to_pdf, :filename => "#{clean_string(Utf8Converter.convert_ka_to_en(filename))}.pdf", :type => 'application/pdf')
						return # to avoid double render call
					}
				end
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
				@platforms = Platform.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.by_economic_category(@economic_category.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "statement.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@economic_category.name} #{t('category.statement.secondary_title')} #{@statement.id}"
						filename << " #{I18n.l Time.now, :format => :file}"
						send_data(kit.to_pdf, :filename => "#{clean_string(Utf8Converter.convert_ka_to_en(filename))}.pdf", :type => 'application/pdf')
						return # to avoid double render call
					}
				end
			end
		end
	end
end
