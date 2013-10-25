require 'yaml'
class Loader
  def initialize
    @modulesDirectories = self.listModules
    @modulesInfos       = self.getInfos
  end

  def listModules
    modulesDirectories = Array.new

    Dir['modules/*/'].each { |directory|
      modulesDirectories.push(directory)
    }
    return modulesDirectories
  end

  def getInfos
    modulesInfos = Array.new

    @modulesDirectories.each { |directory|
      modulesInfos.push(YAML.load_file(directory + 'module.yml'))
    }
    return modulesInfos
  end

  def getTriggers
    modulesTriggers = Array.new

    modulesInfos.each { |module|
      modulesTriggers.push(module["triggers"])
    }
    return modulesTriggers
  end
end