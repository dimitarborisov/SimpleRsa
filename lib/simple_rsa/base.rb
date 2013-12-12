module SimpleRsa
	module KeyPair
		extend self
		
		def load_keys(path = './', key_name = 'srsa_key')

			File.open(path + key_name, 'r') { |file| 
				
				@priv_key = file.read()
			
			}

			File.open(path + key_name + ".pub", 'r') { |file| 
				
				@pub_key = file.read()
			
			}

			return SimpleRsa::Key_pair.new(@pub_key , @priv_key)
		end
		
		def generate_keys(strategy = 'fast', length = 512)
			
			if strategy == 'fast'
				
				#get from already generated primes
				p,q=SimpleRsa::get_primes_list
				
			elsif strategy == 'secure'
				
				#get n/2 bit prime numbers
				p,q=SimpleRsa::get_primes_gen(length/2)
			
			else
				return nil
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

				@pub_key = Base64.encode64("#{k},#{n},#{bits}")  #Base64.encode64( [k, n, bits].to_json )
				@priv_key = Base64.encode64("#{d},#{n},#{bits}") #Base64.encode64( [d, n, bits].to_json )
			
			
			return SimpleRsa::Key_pair.new(@pub_key,@priv_key)
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
