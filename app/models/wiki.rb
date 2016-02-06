class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators



  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end

#What is visible to standard User or collaborator
  def self.visible_to_stand_or_collab(user)
     wikis_to_stand_or_collab=[]
     self.all.each do |wiki|
       if wiki.private==false || wiki.users.include?(user)
         wikis_to_stand_or_collab << wiki
       end
     end
     wikis_to_stand_or_collab
  end

  #What is visible to premium User or collaborator
  def self.visible_to_prem_or_collab(user)
    wikis_to_prem_or_collab=[]
    self.all.each do |wiki|
      if wiki.private==false || wiki.user_id == user.id || wiki.users.include?(user)
        wikis_to_prem_or_collab << wiki
      end
    end
    wikis_to_prem_or_collab
      #where('(private = ? OR user_id = ?)', false, user.id)
  end

  #Chage after User's unsubscription
  def self.all_wikis_to_change(user)
    wikis_to_change=[]
    wikis_to_change = where('(private = ? AND user_id = ?)', true, user.id)
  end

end
