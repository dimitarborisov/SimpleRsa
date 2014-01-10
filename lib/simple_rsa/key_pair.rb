module SimpleRsa
	
	class KeyPair
		
		@pub_key
		@priv_key
		
		def self.load(options = {})
			default = { :path => './', :key_name => 'srsa_key', :pub => true, :priv => true } 
			options = default.merge(options)
			pub_key = priv_key = nil
			
			File.open(options[:path] + options[:key_name], 'r') do |file| 
				priv_key = file.read()
			end if options[:priv] == true
			
			File.open(options[:path] + options[:key_name] + '.pub', 'r') do |file| 
				pub_key = file.read()
			end if options[:pub] == true
			
			SimpleRsa::KeyPair.new(pub_key , priv_key)
		end


		#array 
		#new SimpleRsaKeyPair
		#SimpleRsaKeyPair->generate()
		def self.generate(options = {})
			default = { :strategy => 'secure', :length => 512 } 
			options = default.merge(options)
			length = options[:length]

			if options[:strategy] == 'fast'
				
				#get from already generated primes
				p, q = SimpleRsa::get_primes_list
				
			elsif options[:strategy] == 'secure'
				
				#get n/2 bit prime numbers
				p, q = SimpleRsa::get_primes_gen(length/2)
				puts "DEBUG: #{p} , #{q}"
			else 
				return nil
			end
				#compute modulus
				n = p * q
			
				#calculate phi
				phi=(p-1)*(q-1)
				
				#get coprime number
				k = SimpleRsa::get_co_prime(phi)
			
				#get priv key
				y,d = SimpleRsa::extended_euclid(k,phi) 
			
				#get idea of how big the key is
				bits=SimpleRsa::get_bits(n)

				pub_key = Base64.encode64("#{k},#{n},#{bits}")  #Base64.encode64( [k, n, bits].to_json )
				priv_key = Base64.encode64("#{d},#{n},#{bits}") #Base64.encode64( [d, n, bits].to_json )
			
			
			SimpleRsa::KeyPair.new(pub_key,priv_key)
		end

		def initialize(pub_key, priv_key)
			@pub_key = pub_key
			@priv_key = priv_key
		end
		
		def [](index)
			return @pub_key if index == 0
			return @priv_key if index == 1
		end
		
		def public
			@pub_key
		end
		
		
		def private
			@priv_key
		end
		
		def store(path = './', key_name = 'srsa_key')
			if @pub_key != nil
				File.open(path + key_name + ".pub", 'w') { |file| 
					file.write(@pub_key)
				}
			end

			if @priv_key != nil
				File.open(path+key_name, 'w') { |file| 
					file.write(@priv_key)
				}	
			end
		end
	end
end
