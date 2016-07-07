# SimpleRsa

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'simple_rsa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_rsa

## Usage
###Quick start
1. Create a key pair: 'keys = SimpleRsa::KeyPair.generate'
2. Create an Encryptor with the public key: 'enc = SimpleRsa::Encryptor.new(keys.public)' 
2.1. Encrypt something:  'm = enc.encrypt("hello world!")'
3. Create a Decryptor with the private key: 'dec = SimpleRsa::Decryptor.new(keys.private)'
3.1. Decrypt something: 'dec.decript(m)'

###Slow start
To Do

##Notice
This gem is still not tested for vulnerabilities and correctness of the RSA implementation!
