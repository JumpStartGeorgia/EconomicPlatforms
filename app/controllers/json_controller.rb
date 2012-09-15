class JsonController < ApplicationController

  # /json/party_statement_scores/:political_party_id/:economic_category_id/:indicator_category_id
  def party_statement_scores
    json = Hash.new
    
    if params[:political_party_id] && !params[:political_party_id].empty? &&
        params[:economic_category_id] && !params[:economic_category_id].empty? && 
        params[:indicator_category_id] && !params[:indicator_category_id].empty?

      # get the party scores
      scores = Statement.daily_average(params[:political_party_id], params[:economic_category_id], params[:indicator_category_id])
      
      # get the party platform score
      platform_score = Platform.score(params[:political_party_id], params[:economic_category_id], params[:indicator_category_id])
      
      # get the all party platform average
      all_party_average = Platform.all_party_average(params[:economic_category_id], params[:indicator_category_id])
      
      # put together in nice format
      # {party  cat  ind  title  scale={top  middle  bottom}  values=[{x  y}]  guidlines={party_plat  all_parties_plat}}
      json['political_party'] = scores.first.political_party_name
      json['economic_category'] = scores.first.economic_category_name
      json['indicator_category'] = scores.first.indicator_category_name
      json['title'] = ''
      json['scales'] = Hash.new
      json['scales']['top'] = t('app.directions.left')
      json['scales']['middle'] = t('app.directions.center')
      json['scales']['bottom'] = t('app.directions.right')
      json['values'] = Array.new(scores.length) {Hash.new}
      scores.each_with_index do |score, index|
        json['values'][index]['x'] = I18n.l(score.date_made, :format => :default)
        json['values'][index]['y'] = score.daily_avg_score
      end
      json['guidelines'] = Hash.new
      json['guidelines']['party_platform_score'] = platform_score.first.score_value
      json['guidelines']['all_party_platform_avg_score'] = all_party_average.to_f
    end
    
    respond_to do |format|
      format.json { render json: json.to_json }
    end
  end

end