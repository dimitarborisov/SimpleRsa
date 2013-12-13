module SimpleRsa
	
	class Encryptor
		
		@coprime
		@modulus
		@keysize

		def initialize(key)
			
			#k, r, keysize
			key = Base64.decode64(key)
			@coprime, @modulus, @keysize = key.split(',').map(&:to_i)
		
		end
		
		def encrypt(text)
			
			blocks = SimpleRsa::gen_blocks(text, @keysize)
			out = String.new
		
			blocks.each do |block| 
				if block
					cryptblock = SimpleRsa::crypt_num(SimpleRsa::txt_to_num(block), @coprime, @modulus)
					out << cryptblock.to_s
					out <<  ":::"  
				end
			end
			
			Base64.encode64(out);
		end
	
	end

end
