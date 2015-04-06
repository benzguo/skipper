require 'timers'

timers = Timers::Group.new
counter = 0
target_min = 31 
buffer_range = 10
target = target_min

def check_repeat()
	current_repeat = `osascript -e 'tell application "Spotify" to repeating'`
	if current_repeat.include? "false"
		`osascript -e 'tell application "Spotify" to set repeating to not repeating'`
		puts "turned on repeat"
	end
end

def check_shuffle()
	current_shuffle = `osascript -e 'tell application "Spotify" to shuffling'`
	if current_shuffle.include? "false"
		`osascript -e 'tell application "Spotify" to set shuffling to not shuffling'`
		puts "turned on shuffle"
	end
end

check_repeat()
check_shuffle()

timers.every(1) { 
	counter += 1
	if counter == target
		check_repeat()
		check_shuffle()
		puts "waited #{counter}s"
		`osascript -e 'tell application "Spotify" to next track'`
		target = target_min + rand(buffer_range)
		counter = 0
	end
}

loop { timers.wait }