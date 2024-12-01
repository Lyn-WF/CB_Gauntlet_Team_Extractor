class Tape
	def initialize(beast_name)
		@beast = beast_name
		@stickers = []
		@bootleg = "vanilla"
		@difficulty = "any"
	end
	
	def add_sticker(name)
		@stickers.append(name)
	end
	
	def add_bootleg(type)
		@bootleg = type
	end
	
	def add_difficulty(difficulty)
		@difficulty = difficulty
	end
	
	def log_tape()
		puts("Tape: #{@beast}")
		if @bootleg != "vanilla"
			puts("#{@bootleg} Bootleg")
		end
		puts("Stickers:")
		@stickers.each do |sticker|
			puts(" -#{sticker}")
		end
		if @difficulty != "any"
			puts("#{@difficulty}")
		end
	end
end