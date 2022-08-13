# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActiveSupport.escape_html_entities_in_json = true 