require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'

include Warden::Test::Helpers

Capybara.javascript_driver = :poltergeist