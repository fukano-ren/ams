class Belong < ActiveRecord::Base
	belongs_to :department
	belongs_to :user

	soft_deletable

  validates :code, presence: true
  validates :name, presence: true
  validates :code, uniqueness: true

end
