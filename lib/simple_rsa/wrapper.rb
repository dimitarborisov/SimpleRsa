
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
	def get_primes_gen(bits = 512)
			
		
		p=SimpleRsa::get_num(bits)
		q=SimpleRsa::get_num(bits)
		
		while miller_rabin_test(p, 800) != true
			p += 8
		end
		
		while miller_rabin_test(q, 800) != true
			q += 8
		end
		
		return p,q
	end	
		

end
