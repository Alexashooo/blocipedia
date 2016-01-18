class Wiki < ActiveRecord::Base
  belongs_to :user

#What is visible to standard User
  def self.visible_to_standard
        where(private: false)
  end

  #What is visible to premium User
  def self.visible_to_premium(user)
      where('(private = ? OR user_id = ?)', false, user.id)
  end

  #Chage after User's unsubscription
  def self.all_wikis_to_change(user)
    wikis_to_change=[]
    wikis_to_change=where('(private = ? AND user_id = ?)', true, user.id)
  end
  

end
