# frozen_string_literal: true

require 'net/http'
# Represents a URL that can be shortened to a unique, randomly generated identifier.
# Public methods:
# - to_param: Returns short attribute as the parameter for url
# - normalize_target: Adds https:// to target if not present and contains www.
# - validate_target_url: Ensures that link is valid by getting the title tag using regex
class Url < ApplicationRecord

  # Validations
  validates :target, presence: true, format: {  with: /\A(https?):\/\/[^\s\/$.?#].[^\s]*\z/i, message: 'must be a valid URL' }
  validate :validate_target_url
  validates :short, presence: true, uniqueness: true
  validates :title, presence: true
  before_validation :normalize_target

  # Returns short attribute as the parameter for url
  def to_param
    short
  end

  private 

  def normalize_target
    return if target.blank?

    self.target = "https://#{target}" if target.match?(/\Awww\./) && !target.start_with?("http://", "https://")
  end

  def validate_target_url
    return errors.add(:target, 'is not valid URL') unless target =~ /\A(https?):\/\/[^\s\/$.?#].[^\s]*\z/i

    uri = URI.parse(target)
    response = Net::HTTP.get_response(uri)
    # Loop to account for redirecting websites
    loop do
      response = Net::HTTP.get_response(uri) 
      # If it's a redirect, update the URI and try again
      if response.is_a?(Net::HTTPRedirection)
        uri = URI.parse(response['location'])
      else
        break
      end
    end
    if response.is_a?(Net::HTTPSuccess)
      self.title = response.body.match(/<title>(.*?)<\/title>/)[1]
    else
      errors.add(:target, 'is not valid target')
    end
  end
end
