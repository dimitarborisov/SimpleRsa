module SimpleRsa
	
	class Decryptor
		
		@key
		
		def initialize(key)
			
			#q, r, keysize
			@key = Base64.decode64(key)
			@key = @key.split(',')

			@key[0] = @key[0].to_i
			@key[1] = @key[1].to_i
			@key[2] = @key[2].to_i
		end
		
		def decrypt(code) 
		
			code=Base64.decode64(code);
			blocks = code.split(":::")
			out = String.new

			blocks.each do |block|
				if block 
					out << SimpleRsa::num_to_txt(SimpleRsa::crypt_num(block.to_i, @key[0], @key[1]))
				end
			end
		
			return out;
		end
	
	end

end
