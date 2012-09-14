class Comment < ActiveRecord::Base
  require 'split_votes'
  include SplitVotes

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

 #belongs_to :user

end
