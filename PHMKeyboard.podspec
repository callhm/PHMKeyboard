#
# Be sure to run `pod lib lint PHMKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PHMKeyboard'
  s.version          = '1.0.3'
  s.summary          = 'A short description of PHMKeyboard.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/callHM/PHMKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PHM' => '251962881@qq.com' }
  s.source           = { :git => 'https://github.com/callHM/PHMKeyboard.git', :commit => 'e2e6697c264cf23be0ba468b6c251a3ddfd8fb50'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'
  s.source_files = 'PHMKeyboard/Classes/*.{h,m}'
  s.requires_arc = true

  # s.resource_bundles = {
  #   'PHMKeyboard' => ['PHMKeyboard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.ios.frameworks = 'Foundation', 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
