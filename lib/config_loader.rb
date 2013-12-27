require 'yaml'

# Helps to load config files in salemove ecosystem
#
class ConfigLoader
  # Load given config file
  #
  # @path [String] path
  #   full path to config
  # @path [String] env
  #   environment to load
  #
  # @return [Hash]
  #   hash with symbolized keys
  #
  # @api public
  def self.load(path, env)
    hash = YAML.load_file(path)[env]
    normalize_hash(hash)
  end

  # Converts string keys into symbol keys
  #
  # @param [Hash] hash
  #
  # @return [Hash]
  #   normalized hash
  #
  # @api private
  def self.normalize_hash(hash)
    hash.each_with_object({}) do |(key, value), normalized_hash|
      normalized_value = value.is_a?(Hash) ? normalize_hash(value) : value
      normalized_hash[key.to_sym] = normalized_value
    end
  end
end
