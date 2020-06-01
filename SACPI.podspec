
Pod::Spec.new do |s|
  s.name             = 'SACPI'
  s.version          = '1.0.10'
  s.summary          = 'SuperAwesome CPI solution for iOS'
  s.description      = <<-DESC
SACPI contains all code required to run the CPI solution for iOS
                       DESC
  s.homepage         = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-cpi'
  s.license          = { :type => 'GNU LESSER GENERAL PUBLIC LICENSE Version 3', :file => 'LICENSE' }
  s.author           = { 'Gabriel Coman' => 'gabriel.coman@superawesome.tv' }
  s.source           = { :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-cpi.git', :tag => "1.0.10" }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAUtils', '1.5.6'
  s.dependency 'SANetworking', '1.0.1'
  s.dependency 'SASession', '1.1.3'
  s.dependency 'SAModelSpace', '1.0.1'
end
