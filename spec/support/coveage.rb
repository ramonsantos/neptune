# frozen_string_literal: true

require 'simplecov'

if ENV['LCOV_FORMATTER']
  require 'simplecov-lcov'

  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.lcov_file_name = 'lcov.info'
  end

  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
end

SimpleCov.start 'rails' do
  add_filter [
    'app/channels',
    'app/jobs',
    'app/mailers'
  ]
end

SimpleCov::MINIMUM_COVERAGE = 95
SimpleCov.minimum_coverage SimpleCov::MINIMUM_COVERAGE
