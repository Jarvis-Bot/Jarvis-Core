require 'erb'
require 'fileutils'
class FilesGenerator
  def initialize(template_path, file_name, path)
    @template_path = template_path
    @file_name = file_name
    @path = path
    @template = File.read(File.join(template_path, "#{file_name}.erb"))
  end

  def generate
    @rendered = ERB.new(@template).result
    create_folder unless Dir.exist?(@path)
    File.open(File.join(@path, @file_name), 'w') do |f|
      f.write(@rendered)
    end
  end

  def create_folder
    FileUtils.mkdir(@path)
  end
end
