module Spree
	class ContactTopic < ActiveRecord::Base
	
		attr_accessible :name, :emails
		
	  validates :name, :emails, :presence => true
	  validates :name,          :uniqueness => true
	end
end
