Pod::Spec.new do |s|
  s.name             = "JMActionSheetDescription"
  s.version          = "0.4.1"
  s.summary          = "Make a description of your actionSheet 2.0."
  s.description      = <<-DESC
                       JMActionSheetDescription is a descriptor component. Write your actionSheet description and let
                       the framework generate your custom actionSheet.
                       Customizable elements : button font, color, background.
                       Cool added elements are : an PickerView,
                                                 an Horizontal carousel of iconified actions,
                                                 an Horizontal carousel of images,
                                                 an image to help understanding the context of action,
                                                 an URL (in progress),
                                                 an text (in progress).
                       DESC
  s.homepage         = "https://github.com/leverdeterre/JMActionSheetDescription"
  s.screenshots      = "https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/demo.gif?raw=true", 						"https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/ipads.png?raw=true", "https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/iphones.png?raw=true"
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
