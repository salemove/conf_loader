require 'yaml'
require 'symbolizer'
require 'erb'

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
    template = ERB.new File.new(path).read
    environments = YAML.load template.result(binding)
    hash = environments[env]
    Symbolizer.symbolize(hash)
  end
end
