class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title,:description,:user_id
end
