# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Metron::Application.config.secret_key_base = 'b45153361b6b81bc4f86c2c4f895b931fc486eff88203a61847f71c0b31b9a0dd7e98970cb25a9569ec24285c24f09615722bed33fd467bc890d1abfde6706f7'
