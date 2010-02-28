# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rozklad-mpk.czest.pl_session',
  :secret      => 'ce3653d2bf0bd3ede26e5be0d8a2882b096355c98dcf9bf7153ea9b3225ff42c13f537855a47cf57c4bbec702700ec8ae76fa0719b09b903ca54b522851a705b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
