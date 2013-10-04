class CategoryController < ApplicationController
	require 'utf8_converter'

	def index
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		else
			@indicator_categories = IndicatorCategory.with_indicators.sorted

      @statements = nil
      if params[:political_party_id] && !params[:political_party_id].empty?
        # get statements for the pass in pol party id
  	    @statements = Statement.sorted.by_political_party(params[:political_party_id])
  	      .by_economic_category(@economic_category.id)
  	      .published.paginate(:page => params[:page])
				political_party = @political_parties_nav.select{|x| x.id.to_s == params[:political_party_id]}
				@political_party_name = political_party.first.name if political_party && !political_party.empty?
      else
        # get statements for the first ec cat that has statements
        @political_parties_nav.each do |pp|
    	    @statements = Statement.sorted.by_political_party(pp.id)
  	      .by_economic_category(@economic_category.id)
    	      .published.paginate(:page => params[:page])
    	    if @statements && !@statements.empty?
    	      params[:political_party_id] = pp.id.to_s
    	      break
    	    end
  	    end
  	    # assign default value for ind category drop down
        params[:indicator_category_id] = 5
      end

			@platforms = Platform.published.by_economic_category(@economic_category.id)
			@policy_briefs = PolicyBrief.published.by_economic_category(@economic_category.id)

			gon.category_profile = true
      gon.category_statement_chart_data = true
      gon.json_data = Statement.sorted.categiry_statement_scores_json(
        params[:political_party_id],
        @economic_category.id,
        params[:indicator_category_id])

			gon.highlight_first_form_field = false

		  respond_to do |format|
		    format.html # index.html.erb
		    format.json { render json: @statements }
		  end
		end
	end

	def platform
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id]).by_election(election_id)
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@political_party
			redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
		else
			@platform = Platform.published.by_party_category(@political_party.id, @economic_category.id)

			if !@platform
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.published.by_economic_category(@economic_category.id)
				@comments = @platform.comments

				gon.highlight_first_form_field = false
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
		@political_party = PoliticalParty.find_by_permalink(params[:political_party_id]).by_election(election_id)
		@economic_category = EconomicCategory.find_by_permalink(params[:economic_category_id])
		if !@economic_category
			redirect_to root_path, notice: t('app.msgs.does_not_exist')
		elsif !@political_party
			redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
		else
			@policy_brief = PolicyBrief.published.by_party_category(@political_party.id, @economic_category.id)

			if !@policy_brief
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.published.by_economic_category(@economic_category.id)
				@comments = @policy_brief.comments

				gon.highlight_first_form_field = false
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
		  @statements = Statement.sorted.published.by_economic_category(@economic_category.id).where(:id => params[:id])
			@statement = @statements.first if @statements && !@statements.empty?

			if !@statement
				redirect_to category_path(params[:economic_category_id]), notice: t('app.msgs.does_not_exist')
			else
				@platforms = Platform.published.by_economic_category(@economic_category.id)
				@policy_briefs = PolicyBrief.published.by_economic_category(@economic_category.id)
				@comments = @statement.comments

				gon.highlight_first_form_field = false
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
