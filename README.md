# SimpleRsa

Simple implementation of RSA algorithm.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_rsa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_rsa

## Usage
###Quick start
1. Create a key pair: `keys = SimpleRsa::KeyPair.generate`
2. Create an Encryptor with the public key: `enc = SimpleRsa::Encryptor.new(keys.public)`
 + Encrypt something:  `m = enc.encrypt("hello world!")`.
3. Create a Decryptor with the private key: `dec = SimpleRsa::Decryptor.new(keys.private)`
 + Decrypt something: `dec.decript(m)`

###Slow start
`SimpleRsa::KeyPair.generate(options = {})` returns a pair of keys where `option` is used for additional control 

`options` includes `:strategy` and `:length`

`:strategy` can be `"secure"` or `"fast"`
 + `"fast"` creates a keypair from already generated prime numbers(`:length` is ignored and the key pair is of small length)
 + `"secure"` generates a new keypair with relative size = `:length`    


`:length` is the size of the key(it should be > 2). The prime number generation is pseudorandom so keys with `:length` > 1024 may take a long time depending on your processor.
Default value is 512.


to be continue...
##Notice
This gem is still not tested for vulnerabilities and correctness of the RSA implementation!
