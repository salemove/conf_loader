require 'yaml'
require 'symbolizer'
require 'erb'

# Helps to load conf files in salemove ecosystem
#
class ConfLoader
  EnvironmentNotFoundError = Class.new(KeyError)
  ValueNotDefinedError = Class.new(KeyError)

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

      check_value_presence(
        guarantee_key_presence(Symbolizer.symbolize(hash))
      )
    else
      raise EnvironmentNotFoundError,
        "Configuration for `#{env}` not found at path #{path}"
    end
  end


  private_class_method

  def self.guarantee_key_presence(hash)
    hash.default_proc = proc do |h, k|
      raise KeyError, "#{k} not defined"
    end
    hash
  end

  def self.check_value_presence(hash)
    errors = check_values_not_empty(hash)
    if errors.empty?
      hash
    else
      raise ValueNotDefinedError, errors.join(', ')
    end
  end

  def self.check_values_not_empty(hash)
    hash.inject([]) do |acc, (key, value)|
      errors =
        if value.is_a?(Hash)
          check_values_not_empty(value)
        elsif value.to_s.empty?
          ["#{key} value not defined"]
        else
          []
        end
      acc + errors
    end
  end
end
