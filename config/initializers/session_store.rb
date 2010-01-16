# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mysnaplog_session',
  :secret      => '732fda60fc4e92e9a54b4443c9b6c48c66a49e0b24cb31dfacbefced29d80553e00b835f84d4c9001d50e890785828a8e09f7e61f88d2ee1700ea3f874102f7a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
