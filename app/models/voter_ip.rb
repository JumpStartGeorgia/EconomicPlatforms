class Voter_ip < ActiveRecord::Base
attr_accessible :ip, :votable_id, :votable_type, :status


end
