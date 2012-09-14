class Comment < ActiveRecord::Base
  require 'split_votes'
  include SplitVotes

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'if (vote is null, 0, (substring(vote, 2, (locate(\'-\', vote) - 2)) - substring(vote,  (locate(\'-\', vote) + 1)))) desc, created_at ASC'

#SELECT vote, if (vote is null, '+0-0', vote) as voten, if (vote is null, 0, (substring(vote, 2, (locate('-', vote) - 2)) - substring(vote,  (locate('-', vote) + 1)))) as diff, created_at, id, comment FROM `comments` order by diff desc, created_at asc


 #belongs_to :user

end
