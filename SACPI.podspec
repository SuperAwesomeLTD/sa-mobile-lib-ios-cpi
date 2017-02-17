
Pod::Spec.new do |s|
  s.name             = 'SACPI'
  s.version          = '1.0.3'
  s.summary          = 'SuperAwesome CPI solution for iOS'
  s.description      = <<-DESC
SACPI contains all code required to run the CPI solution for iOS
                       DESC
  s.homepage         = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-cpi'
  s.license          = { :type => 'GNU LESSER GENERAL PUBLIC LICENSE Version 3', :file => 'LICENSE' }
  s.author           = { 'Gabriel Coman' => 'gabriel.coman@superawesome.tv' }
  s.source           = { :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-cpi.git', :tag => "1.0.3" }
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAUtils', '1.5.0'
  s.dependency 'SANetworking', '0.2.9'
  s.dependency 'SASession', '0.3.5'
  s.dependency 'SAModelSpace', '0.4.3'
end
