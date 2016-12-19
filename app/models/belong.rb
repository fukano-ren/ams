class Belong < ActiveRecord::Base
	belongs_to :department
	belongs_to :user

	soft_deletable
end
