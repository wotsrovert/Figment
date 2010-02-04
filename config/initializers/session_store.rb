# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_figment_session',
  :secret      => '9b3fb456e71764c3c543dc1582594d394de835367056c5f83af6e1c42f8b692b4c542b7af977e0b7d514b33efb25e9dddbcea47a594bf0ef521ca03d3882dc4d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
