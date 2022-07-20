Pod::Spec.new do |s|
  s.name = 'Passcode'
  s.version = '1.1'
  s.platform = :ios
  s.license = 'MIT'
  s.summary = 'Generate A Passcode'
  s.homepage = 'https://github.com/mhamidg/Passcode'
  s.author = { 'Hamid Farooq' => 'mhamidg@gmail.com' }
  s.source = { :git => 'https://github.com/mhamidg/Passcode.git', :tag => s.version.to_s }

  s.description = 'Create/Forgot Passcode'
  s.requires_arc = true

  s.source_files = 'Passcode/**/*'
end

