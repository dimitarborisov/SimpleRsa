require "base64"
require "json"

module SimpleRsa
		
	def modular_pow(base, exponent, modulus)
		result = 1 
		base = base % modulus
		
		until exponent.zero?
			exponent.odd? and result = (result * base) % modulus
			exponent >>= 1
			base = (base * base) % modulus
		end 

		return result 
	end
	
	def get_bits(num)
			
		count=0
		while num > 0 do
			num = num >> 1
			count += 1
		end
			
		return count
	end
		
	def get_co_prime(phi)
			
		k=3
			
		while(get_gcd(k,phi)!=1) do
			k+=2
		end
			
		return k
	end
		
	def extended_euclid(k=3,phi=280)
		s = 0;    olds = 1
		t = 1;    oldt = 0
		r = k;    oldr = phi
		while r != 0 do
			quotient = oldr / r
	
			temp=oldr
			oldr=r 
			r=temp-quotient *r
	
			temp=olds
			olds=s
			s =temp-quotient *s
	
			temp= oldt
			oldt = t
			t = temp-quotient *t     
		end
			
		oldt += phi if oldt < 0 
		olds += k if olds < 0
			
		return olds, oldt
		#puts"Bezout coefficients:", olds, oldt
		#puts "greatest common divisor:", oldr
		#puts "quotients by the gcd:" , t, s

	end
	
	def get_priv_key(k, phi)
			
		d=1
				
		while((d * k) % phi != 1) do
			d+=1
		end
			
		return d
	end

	def get_gcd(a, b)
		while b!=0 do
			m = a % b
			a = b
			b = m
		end

		return a
	end
	
	def gen_blocks(data, keysize=1)
		
		#Calculate blocksize by keysize (8 bit)
		block_size=(keysize/8).floor
		
		return data.scan(/.{1,#{block_size}}/)
	end
	
	
	def txt_to_num(str)
		#Turns regular text into a number that can be manipulated by the RSA algorithm
		result = 0
		n = str.length
		while n > 0 do
			n=n-1
			result = (result*256) + str[n].ord;
		end
		
		return result
	end
	
	def num_to_txt(num)
		#Turns the numeric representation of text (as output by txt_to_num) back into text
		result = String.new
		
		while num > 0 do 
			
			result << (num%256).chr
			num = num / 256
		
		end
		return result;
	end
		
end