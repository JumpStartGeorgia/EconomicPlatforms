module SplitVotes
    
  def self.included (base)
    base.extend ClassMethods
  end


  def votes_up
    return 0 if (self.vote.nil? || self.vote.length < 4)
    self.vote.clone.split('+')[1].split('-')[0]
  end

  def votes_down
    return 0 if (self.vote.nil? || self.vote.length < 4)
    self.vote.clone.split('+')[1].split('-')[1]
  end

  def votes_diff
    return {:number => 0, :color => 'grey'} if (self.vote.nil? || self.vote.length < 4)
    f = self.vote.clone.split('+')[1].split('-')
    number = f[0].to_i - f[1].to_i
    if number > 0
      color = 'green'
    elsif number == 0
      color = 'grey'
    else
      color = 'red'
    end
    {:number => number, :color => color}
  end

  def voted (ip, status)
    record = Voter_ip.where(:ip => ip, :votable_type => self.class.name.downcase, :votable_id => self.id, :status => status)
    return !(record.nil? || record.empty?)
  end
    
  module ClassMethods
  end

end
