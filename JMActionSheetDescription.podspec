Pod::Spec.new do |s|
  s.name             = "JMActionSheetDescription"
  s.version          = "0.1.0"
  s.summary          = "A short description of JMActionSheetDescription."
  s.description      = <<-DESC
                       
                       DESC
  s.homepage         = "https://github.com/leverdeterre/JMActionSheetDescription"
  s.screenshots      = "https://github.com/leverdeterre/JMActionSheetDescription/screenshots/demo.gif"
  s.license          = 'MIT'
  s.author           = { "Jérôme Morissard" => "morissardj@gmail.com" }
  s.source           = { :git => "https://github.com/leverdeterre/JMActionSheetDescription.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/leverdeterre'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  #s.resource_bundles = {
  #  'JMActionSheetDescription' => ['Pod/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
