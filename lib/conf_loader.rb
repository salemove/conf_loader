require 'yaml'
require 'symbolizer'
require 'erb'

# Helps to load conf files in salemove ecosystem
#
class ConfLoader
  EnvironmentNotFoundError = Class.new(KeyError)

  # Load given conf file
  #
  # @path [String] path
  #   full path to conf
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

    if environments.has_key?(env)
      hash = environments[env]
      Symbolizer.symbolize(hash)
    else
      raise EnvironmentNotFoundError,
        "Configuration for `#{env}` not found at path #{path}"
    end
  end
end
