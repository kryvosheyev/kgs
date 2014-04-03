class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title,:description,:user_id

  validates :title, length: { minimum: 3}, presence: true 
  validates :description, length: { minimum: 5, allow_blank: true }

  scope :empty_desc, -> { where( description: nil ) }
end
