#!/usr/bin/ruby
require_relative 'vehicle_detail'

begin
parking_slots = []
slot_count = 0
counter = 0
	while (true) do
		input_command = gets.split(" ") rescue []
		parking_lot_action = input_command[0].to_s
		counter = 0 if !parking_lot_action.empty?
		case(parking_lot_action)
		when "create_parking_lot"
			parking_slots = []
			slot_count = input_command[1].to_i
			slot_count.times.each {|count| parking_slots << VehicleDetail.new(count+1,nil,nil,false) }
			puts "Created a parking lot with #{slot_count} slots"
		when "park"
			first_available_slot = parking_slots.select {|slot| !slot.occupied? }  
			if !first_available_slot.empty?
				parking_slot = first_available_slot.first
				vehicle_number = input_command[1] 
				vehicle_color = input_command[2]
				parking_slot.set_vehicle_details(vehicle_number,vehicle_color,true)
				puts "Allocated slot number: #{parking_slot.slot_number}"
			elsif slot_count == 0
				puts "Create A Parking Lot to proceed" 
			else
				puts "Sorry, parking lot is full"
			end
		when "leave"
			slot_number = input_command[1].to_i
			parking_slot = parking_slots.find {|slot| slot.slot_number == slot_number }  
			if slot_count == 0
				puts "Create A Parking Lot to proceed" 
			elsif !parking_slot.nil? && parking_slot.occupied?
				parking_slot.set_vehicle_details(nil,nil,false)
				puts "Slot number #{slot_number} is free"
			else 
				puts "Slot number #{slot_number} is already free"
			end
			
		when "status"
			puts "Slot No. Registration No Colour"
			parking_slots.each do |parking_slot|
				puts "#{parking_slot.slot_number} #{parking_slot.registration_number} #{parking_slot.vehicle_color}" if parking_slot.occupied?
			end
		when "registration_numbers_for_cars_with_colour","slot_numbers_for_cars_with_colour"
			color = input_command[1]
			result_data = parking_lot_action == "registration_numbers_for_cars_with_colour" ? "registration_number" : "slot_number"
			result = []
			parking_slots.select {|slot| slot.occupied? && slot.vehicle_color == color}.each {|vehicle|
				if result_data == "registration_number"
					result << vehicle.registration_number
				else
					result << vehicle.slot_number
				end
			}
			puts "#{result.join(', ')}"
		when "slot_number_for_registration_number"
			registration_number = input_command[1]
			parking_slot = parking_slots.find {|slot| slot.occupied? && slot.registration_number == registration_number }
			if !parking_slot.nil?
				puts parking_slot.slot_number
			else
				puts "Not found"
			end
		when "exit"
			exit(0)
		when ""						
			counter += 1
			exit(0) if counter > 3
		else
			puts "No Command Matched - Enter exit to quit"
		end
	end
end
