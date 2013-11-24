module SimpleRsa
	
	def encrypt(text, key)
		enc_key = JSON::parse(Base64.decode64(key))
		p, r, keysize = enc_key
		blocks = SimpleRsa::gen_blocks(text, keysize)
		out = String.new
		
		blocks.each do |block| 
			if block
				cryptblock = crypt_num(SimpleRsa::txt_to_num(block), p, r)
				out << cryptblock.to_s
				out <<  ":::"  
			end
		end
		
		return Base64.encode64(out);
	end
	
	def decrypt(code, key) 
		enc_key = JSON::parse(Base64.decode64(key))
		q, r, keysize = enc_key
		code=Base64.decode64(code);
		
		blocks = code.split(":::")
		out = String.new

		blocks.each do |block|
			if block 
				out << SimpleRsa::num_to_txt(crypt_num(block.to_i, q, r))
			end
		end
		
		return out;
	end
	
	def crypt_num(num, key, mod)
		#This is where the encryption/decryption happens.
		return SimpleRsa::modular_pow(num, key, mod);
	end
	
end
