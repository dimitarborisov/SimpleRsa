module SimpleRsa
	
	class Key_pair
		
		@pub_key
		@priv_key
		
		def initialize(pub_key, priv_key)
			@pub_key = pub_key
			@priv_key = priv_key
		end
		
		def [](num)
			
			if num > 1 || num < 0
				puts "Valid index 0 or 1"
				return nil
			end
			
			if num == 0
				return @pub_key
			else
				return @priv_key
			end
		end
		
		def public
			return @pub_key
		end
		
		
		def private
			return @priv_key
		end
		
		
		def store(path = './', key_name = 'srsa_key')
			
			
			File.open(path+key_name+".pub", 'w') { |file| 
				file.write(@pub_key)
			}
			
			
			File.open(path+key_name, 'w') { |file| 
				file.write(@priv_key)
			}
			
		end

		def store(path = './', key_name = 'srsa_key')

			File.open(path + key_name + ".pub", 'w') { |file| 
				file.write(@pub_key)
			}

			File.open(path+key_name, 'w') { |file| 
				file.write(@priv_key)
			}


		end

	end


end
