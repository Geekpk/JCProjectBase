#
# Be sure to run `pod lib lint JCProjectBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JCProjectBase'
  s.version          = '0.1.0'
  s.summary          = 'A short description of JCProjectBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Geekpk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arvinky' => 'otw0909@gmail.com' }
  s.source           = { :git => 'https://github.com/Geekpk/JCProjectBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JCProjectBase/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JCProjectBase' => ['JCProjectBase/Assets/*.png']
  # }

  s.requires_arc = true
  s.swift_version = '4.2'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Mantle', '~> 2.1.0'
  s.dependency 'SnapKit', '~> 4.2.0'
  s.dependency 'YYKit', '~> 1.0.9'
  s.dependency 'Alamofire', '~> 4.7.3'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
  s.dependency 'IQKeyboardManager', '~> 6.2.0'
  s.dependency 'MJRefresh', '~> 3.1.15.7'
end
