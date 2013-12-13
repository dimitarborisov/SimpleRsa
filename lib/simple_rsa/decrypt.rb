module SimpleRsa
	
	class Decryptor
		
		@d
		@modulus
		@keysize

		def initialize(key)
			
			#d, r, keysize
			key = Base64.decode64(key)
			@d, @modulus, @keysize = key.split(',').map(&:to_i)

		end
		
		def decrypt(code) 
		
			code=Base64.decode64(code);
			blocks = code.split(":::")
			out = String.new

			blocks.each do |block|
				out << SimpleRsa::num_to_txt(SimpleRsa::crypt_num(block.to_i, @d, @modulus)) if block
			end
		
			out
		end
	
	end

end
