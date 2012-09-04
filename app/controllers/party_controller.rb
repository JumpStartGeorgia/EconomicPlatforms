class PartyController < ApplicationController
	require 'utf8_converter'
	def index
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
	    @statements = Statement.by_political_party(@political_party.id).published.paginate(:page => params[:page])

			@platforms = Platform.by_political_party(@political_party.id).published
			@policy_briefs = PolicyBrief.by_political_party(@political_party.id).published

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
			@platform = Platform.published.by_party_category(@political_party.id, @economic_category.id)

			if !@platform
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.published.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "platform.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@political_party.name} #{t('party.platform.secondary_title', :economic_category => @economic_category.name)}"
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
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@economic_category
			redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
		else
			@policy_brief = PolicyBrief.published.by_party_category(@political_party.id, @economic_category.id)

			if !@policy_brief
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.published.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "policy_brief.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@political_party.name} #{t('party.policy_brief.secondary_title', :economic_category => @economic_category.name)}"
						filename << " #{I18n.l Time.now, :format => :file}"
						send_data(kit.to_pdf, :filename => "#{clean_string(Utf8Converter.convert_ka_to_en(filename))}.pdf", :type => 'application/pdf')
						return # to avoid double render call
					}
				end
			end
		end
	end

	def statement
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id])
		if !@political_party
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
		  @statements = Statement.published.by_political_party(@political_party.id).where(:id => params[:id])
			@statement = @statements.first if @statements && !@statements.empty?

			if !@statement
				redirect_to party_path(params[:political_party_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_political_party(@political_party.id)
				@policy_briefs = PolicyBrief.published.by_political_party(@political_party.id)

				respond_to do |format|
				  format.html # index.html.erb
				  format.json { render json: @statements }
					format.pdf {
						html = render_to_string(:layout => "pdf.html.erb" , :action => "statement.html.erb", :formats => [:html], :handler => [:erb])
						kit = PDFKit.new(html)
						kit.stylesheets << get_stylesheet
						filename = "#{@political_party.name} #{t('party.statement.secondary_title')} #{@statement.id}"
						filename << " #{I18n.l Time.now, :format => :file}"
						send_data(kit.to_pdf, :filename => "#{clean_string(Utf8Converter.convert_ka_to_en(filename))}.pdf", :type => 'application/pdf')
						return # to avoid double render call
					}
				end
			end
		end
	end
end
