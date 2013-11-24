module SimpleRsa
	class Rsa
		
		@pub_key
		@priv_key
		
		def initialize()
			@pub_key = 0
			@priv_key = 0
		end
		
		def get_keys
			return [@pub_key, @priv_key]
		end
		
		def gen_keys(bits = 0, p = 0, q = 0)
			
			if bits==0
				
				#get from already generated primes
				p,q=SimpleRsa::get_primes_list
			
				#compute modulus
				n=p*q
			
				#calculate phi
				phi=(p-1)*(q-1)
				
				#get coprime number
				k=SimpleRsa::get_co_prime(phi)
			
				#get priv key
				y,d=SimpleRsa::extended_euclid(k,phi) 
			
				#get idea of how big the key is
				bits=SimpleRsa::get_bits(n)
				
				@pub_key = Base64.encode64( [k, n, bits].to_json )
				@priv_key = Base64.encode64( [d, n, bits].to_json )
				
			else
				#if bits for key are given do prime generating
			end
			
			return [@pub_key, @priv_key]
		end
		
	end
	
	
end
