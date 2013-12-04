module SimpleRsa
	class Rsa
		
		@pub_key
		@priv_key
		
		def initialize()
			@pub_key = 0
			@priv_key = 0
		end
		
		def [](num)
			if num>1 || num<0
				puts "Valid index 0 or 1"
				return nil
			end
			if num == 0
				return @pub_key
			else
				return @priv_key
			end
		end
		
		def get_priv_key
			return @priv_key
		end
		
		def get_pub_key
			return @pub_key
		end
		
		def get_keys
			return [@pub_key, @priv_key]
		end
		
		def gen_keys(bits = 0)
			
			if bits==0
				
				#get from already generated primes
				p,q=SimpleRsa::get_primes_list
				
			else
				#get n/2 bit prime numbers
				p,q=SimpleRsa::get_primes_gen(bits/2)
			end
				
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
			
			
			return [@pub_key, @priv_key]
		end
		
		def clear_keys
			@pub_key = 0
			@priv_key = 0
		end
		
		def write_pub_key(path = "pub_key")
			
			File.open(path, 'w') { |file| 
				file.write(get_pub_key())
			}
			
		end
		
		def write_keys(path = "keys")
			
			File.open(path, 'w') { |file| 
				file.write(get_keys().to_json) 
			}
			
		end
		
		def write_pub_string(path = "pub_key")
			
			key = JSON::parse(Base64.decode64(get_pub_key()))
			
			pub_string = "#{key[0]},#{key[1]},#{key[2]}"
			pub_string = Base64.encode64(pub_string)
			
			File.open(path, 'w') { |file| 
				file.write(pub_string)
			}
		end
		
		
		def read_keys(path = "keys")
			File.open(path, 'r') { |file| 
				keys = file.read() 
				@pub_key, @priv_key = JSON::parse(keys)
			}
		
		end
		
	end
	
	
end
