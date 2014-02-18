module SimpleRsa
	
	def crypt_num(num, key, mod)
		#This is where the encryption/decryption happens.
		return SimpleRsa::modular_pow(num, key, mod);
	end
	
	
	def modular_pow(base, exponent, modulus)
		result = 1 
		base = base % modulus
		
		until exponent.zero?
			exponent.odd? and result = (result * base) % modulus
			exponent >>= 1
			base = (base * base) % modulus
		end 

		result 
	end
	
	def get_num(bits)
		result = 0
			
		(0..bits-1).each do |i|
			bit = Random.rand(2) << i
			result = result | bit
		end
			
		#to be odd we want 0 bit to be 1
		odd = 1
		result | odd
	end
	
	def get_bits(num)
			
		count = 0
		while num > 0 do
			num = num >> 1
			count += 1
		end
			
		count
	end
		
	def get_co_prime(phi)
			
		k = 3
			
		while(get_gcd(k,phi) !=1 ) do
			k += 2
		end
			
		k
	end
		
	def extended_euclid(k=3,phi=280)
		s = 0;    olds = 1
		t = 1;    oldt = 0
		r = k;    oldr = phi
		while r != 0 do
			quotient = oldr / r
	
			temp = oldr
			oldr = r 
			r = temp-quotient *r
	
			temp = olds
			olds = s
			s = temp-quotient * s
	
			temp = oldt
			oldt = t
			t = temp-quotient * t     
		end
			
		oldt += phi if oldt < 0 
		olds += k if olds < 0
			
		#puts"Bezout coefficients:", olds, oldt
		#puts "greatest common divisor:", oldr
		#puts "quotients by the gcd:" , t, s
		[olds, oldt]	
	end
	
	def get_priv_key(k, phi)	
		d = 1
				
		while((d * k) % phi != 1) do
			d += 1
		end
			
		d
	end

	def get_gcd(a, b)
		
		while b != 0 do
			m = a % b
			a = b
			b = m
		end

		a
	end
	
	#WORKING WITH TEXT
	def gen_blocks(data, keysize=1)
		#Calculate blocksize by keysize (8 bit)
		block_size = (keysize/8).floor
		
		if block_size == 0
			block_size = 1
		end
		
		data.scan(/.{1,#{block_size}}/)
	end
	
	
	
	def txt_to_num(str)
		#Turns regular text into a number that can be manipulated by the RSA algorithm
		result = 0
		n = str.length
		while n > 0 do
			n = n-1
			result = (result*256) + str[n].ord;
		end
		
		result
	end
	
	def num_to_txt(num)
		#Turns the numeric representation of text (as output by txt_to_num) back into text
		result = String.new
		
		while num > 0 do 
			result << (num % 256).chr
			num = num / 256
		end
		result
	end
	
	#PRIME CHECK
	def miller_rabin_test(n = nil, accuracy = 1)
		
		return nil if n.nil?
		
		#compute prime-1 = 2^s * d
		d = n - 1
		s = 0
		
		while d % 2 == 0 do
			s += 1
			d /= 2
		end
		
		for i in 0..accuracy do
			#break from inner loop
			b_check = false
			
			#pick random integer a in the range [2,n - 2]
			a = 2 + rand(n - 4)
			
			#compute modolus of a^d mod n
			x = SimpleRsa::modular_pow(a,d,n)
		
			if x == 1 || x == (n-1)
				next
			end
		
			for i in 1..(s-1) do
				x = (x**2) % n
				return false if x == 1
				b_check = true and break if x == (n-1)
			end
			
			if b_check == true 
				next
			end
			
			return false
		
		end

		return true
	end	
end