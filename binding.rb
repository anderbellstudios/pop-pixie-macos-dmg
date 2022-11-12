module MacOSPackager
  def self.package(build)
    destination_dir = File.join(__dir__, 'public', '.Pop Pixie.app')

    FileUtils.rm_rf(destination_dir)
    FileUtils.cp_r(Dir.glob(File.join(build.dir, '*.app')).first, destination_dir)

    unless system(File.join(__dir__, 'build-installer'))
      raise 'Failed to create macOS installer'
    end

    return File.join(__dir__, 'Install Pop Pixie.dmg')
  end
end
