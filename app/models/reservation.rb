class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing

	def calculate_price

      price_per_night = self.listing.price
      duration = (self.check_out - self.check_in).to_i
      self.total_cost = price_per_night * duration
      self.save
      
	end
end
