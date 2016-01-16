class Wiki < ActiveRecord::Base
  belongs_to :user

  def self.visible_to
       where(public: true)
  end


end
