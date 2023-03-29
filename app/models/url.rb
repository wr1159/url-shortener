# frozen_string_literal: true

# Represents a URL that can be shortened to a unique, randomly generated identifier.
# Public methods:
# - to_param: Returns short attribute as the parameter for url
class Url < ApplicationRecord

  # Validations
  validates :target, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: 'must be a valid URL' }
  validates :short, presence: true, uniqueness: true
  before_validation :normalize_target

  # Returns short attribute as the parameter for url
  def to_param
    short
  end

  private 

  def normalize_target
    return if target.blank?

    self.target = "http://#{target}" if target.match?(/\Awww\./) && !target.start_with?("http://", "https://")
  end
end