# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nasza-faza_session',
  :secret      => '5c45f26ad7921806fadf5dc3eeaf8a4f7116d7247f5a8c0a17f545fefba3109db30f321f2962ac9f1cd460bfa6c1b95baf5e686c50f5c295a8bb3bd4a91c6adf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
