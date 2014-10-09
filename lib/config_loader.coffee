YAML = require 'yamljs'

class ConfigLoader

  CONFIGURATION_FILE_PATH = "./conf/application.yml"

  @loadFor:  (environment, configFilePath=CONFIGURATION_FILE_PATH) ->
    configurations = @_loadFile(configFilePath)
    @_readFor { environment, configurations }

  @_readFor: ({environment, configurations}) ->
    if configurations[environment]?
      configurations[environment]
    else
      throw "Could not find configuration for #{environment} environment"

  @_loadFile: (filePath)->
    YAML.load filePath

module.exports = ConfigLoader
