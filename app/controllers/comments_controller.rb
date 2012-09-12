class CommentsController < ApplicationController

  def create
    case params[:type]
    when 'platform'
      m = Platform
      path = platform_path(params[:commentable_id])
    when 'policy_brief'
      m = PolicyBrief
      path = policy_brief_path(params[:commentable_id])
    when 'statement'
      m = Statement
      path = statement_path(params[:commentable_id])
    else
      redirect_to root_path, :alert => 'wrong commentable'
      return
    end
    commentable = m.find(params[:commentable_id])
    comment = commentable.comments.new
    comment.title = params[:title]
    comment.comment = params[:comment]
    comment.save
    redirect_to :back
  end

  def vote
    case params[:type]
    when 'comment'
      m = Comment
      comment = m.find(params[:votable_id])
      case comment.commentable_type
      when 'platform'
        path = platform_path(comment.commentable_id)
      when 'policy_brief'
        path = policy_brief_path(comment.commentable_id)
      when 'statement'
        path = statement_path(comment.commentable_id)
      end
    when 'platform'
      m = Platform
      path = platform_path(params[:votable_id])
    when 'policy_brief'
      m = PolicyBrief
      path = policy_brief_path(params[:votable_id])
    when 'statement'
      m = Statement
      path = statement_path(params[:votable_id])
    else
      redirect_to root_path, :alert => 'wrong votable'
      return
    end

    ip = request.remote_ip
    record = Voter_ip.where(:ip => ip, :votable_type => params[:type], :votable_id => params[:votable_id])

    if record.nil? || record.empty?
      obj = m.find(params[:votable_id])
      if obj.vote.nil? || obj.vote.length < 3
        obj.vote = '+0-0'
      end

      split = obj.vote.split('+')[1].split('-')
      ups = split[0].to_i
      downs = split[1].to_i
      
      if params[:status] == 'up'
        ups = ups + 1
      elsif params[:status] == 'down'
        downs = downs + 1
      end

      obj.vote = '+' + ups.to_s + '-' + downs.to_s
      obj.save

     #Voter_ip.create(:ip => ip)
      v = Voter_ip.new
      v.ip = ip
      v.votable_type = params[:type]
      v.votable_id = params[:votable_id]
      v.save
    else
      abort false.inspect
    end

    abort Voter_ip.all.inspect

   #redirect_to :back
  end

end
