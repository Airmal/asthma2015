class Xcuser < ActiveRecord::Base
	validates :name, :email, :phone, :office, :company, :address, presence: true
    validates :email, uniqueness: { :case_sensitive => false }
    validates :phone, uniqueness: true
end
