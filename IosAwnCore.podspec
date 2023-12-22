#
# Be sure to run `pod lib lint IosAwnCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IosAwnCore'
  s.version          = '0.8.0'
  s.summary          = 'Awesome Notifications iOS Core'

  s.description      = <<-DESC
Awesome Notifications Ios Core (Only iOS devices).
                       DESC

  s.homepage         = 'https://github.com/rafaelsetragni/IosAwnCore'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { 'Rafael Setragni' => '40064496+rafaelsetragni@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/rafaelsetragni/IosAwnCore.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.static_framework = true
  s.platform = :ios
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.3'

  s.source_files = 'IosAwnCore/Classes/**/*'
  
  s.xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'APPLICATION_EXTENSION_API_ONLY' => 'NO',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }
  
end
