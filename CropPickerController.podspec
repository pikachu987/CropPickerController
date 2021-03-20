#
# Be sure to run `pod lib lint CropPickerController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CropPickerController'
  s.version          = '0.2.0'
  s.summary          = 'There is a single image picker controller for cropping and a multi image picker controller for selecting various images.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
There is a single image picker controller for cropping and a multi image picker controller for selecting various images. You can select an album and it will be updated automatically when you edit the album.
DESC

  s.homepage         = 'https://github.com/pikachu987/CropPickerController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pikachu987' => 'pikachu77769@gmail.com' }
  s.source           = { :git => 'https://github.com/pikachu987/CropPickerController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.swift_version = '5.0'

  s.source_files = 'CropPickerController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CropPickerController' => ['CropPickerController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CropPickerView', '0.2.7'
end
