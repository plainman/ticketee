class Project < ActiveRecord::Base
  has_many :tickets, dependent: :delete_all    #use :destroy when tickets have callbacks
	validates :name, presence: true
end
