require 'timers'

timers = Timers::Group.new
counter = 0
target_min = 30
buffer_range = 10
target = target_min

every_five_seconds = timers.every(1) { 
	counter += 1
	if counter == target
		puts counter
		if counter % 2 == 0 
			system "spotify next"
		else 
			system "spotify prev"
		end
		target = target_min + rand(buffer_range)
		counter = 0
	end
}

loop { timers.wait }