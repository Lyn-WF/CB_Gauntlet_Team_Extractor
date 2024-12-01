require_relative 'Character'
require_relative 'Tape'

class Reader
	def initialize()
		@raw = File.open(ARGV[0]).read
		@keywords = []
		scan_keywords_from_file()
		
		character = Character.new(scan_character_name_from_file(true), true)
		attach_tapes_to_character(character)
		character.log_character()
		
		if file_has_backup()
			character = Character.new(scan_character_name_from_file(false), false)
			attach_tapes_to_character(character)
			puts("")
			puts("- - - - - PARTNER - - - - -")
			puts("")
			character.log_character()
		end
	end
	
	def scan_keywords_from_file()
		keyword_regex = /\[ext_resource path="res:\/\/([a-zA-Z_]+[\/\."])+ type="[a-zA-Z]+" id=[0-9]+\]/
		name_regex = /\/[a-zA-Z\_]+\./
		id_regex = /id=[0-9]+/
		
		@raw.each_line do |line|
			if keyword_regex.match?(line)
				id = Integer(id_regex.match(line)[0][3..-1]) # "id=12" -> 12
				name = name_regex.match(line)[0][1..-2]      # "/smack." -> smack
				@keywords[id] = name
			end
		end
	end
	
	def scan_character_name_from_file(initial_char)
		name_regex = /character_name = "[a-zA-Z_]+"/
		subname_short_regex = /[a-zA-Z_]+_NAME_SHORT/
		subname_regex = /[a-zA-Z_]+_NAME/
		character_backup_regex = /node name="GauntletCharacterConfig2" type="Node"/
		
		active = initial_char # boolean
		
		name = "Name not found"
		@raw.each_line do |line|
			if active
				if name_regex.match?(line)
					name = name_regex.match(line)[0][18..-2] # "character_name = "FRANKIE_NAME" -> FRANKIE_NAME
					if subname_short_regex.match?(name)
						name = name[0..-12] # IANTHE_NAME_SHORT -> IANTHE
					elsif subname_regex.match?(name)
						name = name[0..-6] # FRANKIE_NAME -> FRANKIE
					end
					return name
				end
				if character_backup_regex.match?(line)
					puts("ERROR: Found second character when looking for a character name")
				end
			elsif character_backup_regex.match?(line)
				active = true;
			end
		end
		return "character_name missing (Probably an Archangel or Static Encounter)";
	end
	
	def scan_tapes_from_file(initial_char)
		beast_regex = /form = ExtResource\( [0-9]+ \)/
		bootleg_regex = /type_override = \[ ExtResource\( [0-9]+ \) \]/
		moves_regex = /moves_override = \[ (ExtResource\( [0-9]+ \),? )+\]/
		resource_regex = /ExtResource\( [0-9]+ \)/ # used to pull an array of stickers from a character, but in theory matches any resource
		difficulty_regex = /((require)|(deny))_gauntlet_difficulty = [0-9]+/
		character_backup_regex = /node name="GauntletCharacterConfig2" type="Node"/
		
		active = initial_char
		tapes = []
		current_tape = "not found"
		
		@raw.each_line do |line|
			if active 
				if beast_regex.match?(line)
					if current_tape != "not found"
						tapes.append(current_tape)
					end
					
					beast = @keywords[ Integer( beast_regex.match(line)[0][20..-3] ) ]
					current_tape = Tape.new(beast)
				elsif current_tape == "not found"
					next
				elsif bootleg_regex.match?(line)
					bootleg = @keywords[ Integer( bootleg_regex.match(line)[0][31..-5] ) ]
					current_tape.add_bootleg(bootleg)
				elsif moves_regex.match?(line)
					line.scan(resource_regex) do |sticker_res|
						sticker = @keywords[ Integer( sticker_res[13..-3] ) ]
						current_tape.add_sticker(sticker)
					end
				elsif difficulty_regex.match?(line)
					current_tape.add_difficulty( difficulty_regex.match(line)[0])
				elsif character_backup_regex.match?(line)
					break
				end
			elsif character_backup_regex.match?(line)
				active = true
			end
		end
		if current_tape != "not found"
			tapes.append(current_tape)
		end
		return tapes
	end
	
	def attach_tapes_to_character(character)
		tapes = scan_tapes_from_file(character.is_backup())
		
		tapes.each do |tape|
			character.add_tape(tape)
		end
	end
	
	def file_has_backup()
		character_backup_regex = /node name="GauntletCharacterConfig2" type="Node"/
	
		@raw.each_line do |line|
			if character_backup_regex.match?(line)
				return true
			end
		end
		
		return false
	end
end

Reader.new()