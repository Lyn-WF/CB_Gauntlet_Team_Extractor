class Character
	def initialize(char_name, backup)
		@name = char_name
		@backup = backup
		@tapes = []
	end
	
	def add_tape(tape)
		@tapes.append(tape)
	end
	
	def is_backup()
		return @backup
	end
	
	def log_character()
		puts("Character: #{@name}")
		@tapes.each do |tape|
			puts("")
			tape.log_tape()
		end
	end
end