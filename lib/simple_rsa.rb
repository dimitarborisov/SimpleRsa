require "base64"
require "json"
require_relative "simple_rsa/primes.rb"
require_relative "simple_rsa/math.rb"
require_relative "simple_rsa/key_pair.rb"
require_relative "simple_rsa/version.rb"
require_relative "simple_rsa/prime_handler.rb"
require_relative "simple_rsa/decrypt.rb"
require_relative "simple_rsa/encrypt.rb"

module SimpleRsa
	extend self
end
