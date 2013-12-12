module SimpleRsa
	
	class Encryptor
		
		@key
		
		def initialize(key)
			
			#p, r, keysize
			@key = Base64.decode64(key)
			@key = @key.split(',')

			@key[0] = @key[0].to_i
			@key[1] = @key[1].to_i
			@key[2] = @key[2].to_i		
		end
		
		def encrypt(text)
			
			blocks = SimpleRsa::gen_blocks(text, @key[2])
			out = String.new
		
			blocks.each do |block| 
				if block
					cryptblock = SimpleRsa::crypt_num(SimpleRsa::txt_to_num(block), @key[0], @key[1])
					out << cryptblock.to_s
					out <<  ":::"  
				end
			end
			
			return Base64.encode64(out);
		end
	
	end

end
