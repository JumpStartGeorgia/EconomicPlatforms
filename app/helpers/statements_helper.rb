module StatementsHelper

	# make sure the scores are in the correct order
	def order_scores(scores)
		if scores && !scores.empty?
			new_order = []
			cats = IndicatorCategory.all
			cats.each do |cat|
				score = scores.select{|x| x.indicator_category_id == cat.id}
				if score && !score.empty?
					new_order << score.first
				end
			end
			return new_order if !new_order.empty?
		end
	end
end
