Pod::Spec.new do |s|
  s.name             = "JMActionSheetDescription"
  s.version          = "0.4.8"
  s.summary          = "JMActionSheetDescription replace UIActionSheet and UIActivityViewController."
  s.description      = <<-DESC
                       JMActionSheetDescription is a descriptor component. It replace your ActionSheet and UIActivityViewController usage. Write your actionSheet description and let the framework generate your custom action representation. (Support iOS9 SplitView !)

                       Customizable elements : button font, color, background.
                       Cool added elements are : an PickerView,
                                                 an Horizontal carousel of iconified actions,
                                                 an Horizontal carousel of images,
                                                 an image to help understanding the context of action,
                                                 an URL (in progress),
                                                 an text (in progress).
                       DESC
  s.homepage         = "https://github.com/leverdeterre/JMActionSheetDescription"
  s.screenshots      = "https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/ipads.png?raw=true", "https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/iphones.png?raw=true","https://github.com/leverdeterre/JMActionSheetDescription/blob/master/screenshots/ipad-splitview-2.png?raw=true"
  s.license          = 'MIT'
  s.author           = { "Jérôme Morissard" => "morissardj@gmail.com" }
  s.source           = { :git => "https://github.com/leverdeterre/JMActionSheetDescription.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/leverdeterre'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JMActionSheetDescription' => ['Pod/Assets/*.png']
  }

end
