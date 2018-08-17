class Task < ActiveRecord::Base
  belongs_to :event
  has_one :user, through: :event
  validates :name, presence: :true
end
