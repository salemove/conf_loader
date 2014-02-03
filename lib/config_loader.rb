require 'yaml'
require 'symbolizer'

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
    Symbolizer.symbolize(hash)
  end
end
