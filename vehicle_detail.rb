class VehicleDetail
	def initialize(slot_number,registration_number,vehicle_color,occupied)
		@slot_number = slot_number
		@registration_number = registration_number
		@vehicle_color = vehicle_color
		@occupied = occupied
	end

	def slot_number
		@slot_number
	end

	def registration_number
		@registration_number
	end

	def vehicle_color
		@vehicle_color
	end

	def occupied?
		@occupied
	end

  	def set_vehicle_details(registration_number,vehicle_color,occupied)
		@registration_number = registration_number
		@vehicle_color = vehicle_color
		@occupied = occupied
  	end
end