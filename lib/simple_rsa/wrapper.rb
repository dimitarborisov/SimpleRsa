
module SimpleRsa

	def get_primes_list
		#primes
		q,p=0			
			
		#pseudo random actions for generating group for small prime
		entrophy = Random.new_seed
			
		if entrophy % 2 == 0	
			q=Primes::SMALL_PRIMES_G1.sample.to_i
		else
			q=Primes::SMALL_PRIMES_G2.sample.to_i
		end	
			
			
		#repeat pseudo random actions for generating group for large prime			
		entrophy = Random.new_seed
			
		if entrophy % 2 == 0	
			p=SimpleRsa::Primes::BIG_PRIMES_G1.sample.to_i
		else
			p=SimpleRsa::Primes::BIG_PRIMES_G2.sample.to_i
		end	
			
		return [q,p]
			
	end 
		
	
	#need a check for prime
	def get_primes_gen(bits = 1024)
			
		result=0
			
		(0..bits-1).each do |i|
			bit = Random.rand(2) << i
			result= result | bit
		end
			
		#to be odd we want to be sure 0 bit is 1
		odd=1
		result= result | odd
		
		
		
		return result
	end	
		

end
