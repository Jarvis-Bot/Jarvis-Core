require 'yaml'
require 'pp'
class Loader
  def self.listModules
    modulesDirectories = Array.new
    
    Dir['modules/*/'].each { |directory|
      modulesDirectories.push(directory)
    }
    return modulesDirectories
  end

  def self.getInfos
    modulesDirectories = self.listModules
    modulesInfos = Array.new

    modulesDirectories.each { |directory|
      modulesInfos.push(YAML.load_file(directory + 'module.yml'))
    }
    return modulesInfos
  end
end

pp Loader.listModules
pp Loader.getInfos