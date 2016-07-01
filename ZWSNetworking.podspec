#
# Be sure to run `pod lib lint ZWSNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZWSNetworking"
  s.version          = "1.0.2"
  s.summary          = "ZWSNetworking refer to Casa Taloyum."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ZWSNetworking refer to Casa Taloyum.
                       DESC

  s.homepage         = "https://github.com/zhengweishu/ZWSNetworking"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zhengweishu" => "git@zhengweishu.com" }
  s.source           = { :git => "https://github.com/zhengweishu/ZWSNetworking.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'ZWSNetworking/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZWSNetworking' => ['ZWSNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.1.0'
end
