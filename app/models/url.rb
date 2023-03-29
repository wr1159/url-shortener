# frozen_string_literal: true

# Represents a URL that can be shortened to a unique, randomly generated identifier.
# Public methods:
# - to_param: Returns short attribute as the parameter for url
class Url < ApplicationRecord
  # Returns short attribute as the parameter for url
  def to_param
    short
  end
end
