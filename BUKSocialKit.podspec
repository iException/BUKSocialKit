Pod::Spec.new do |s|
  s.name     = 'BUKSocialKit'
  s.version  = '0.0.5'
  s.license  = 'MIT'
  s.summary  = 'Baixing Social Share Kit'
  s.homepage = 'https://github.com/iException/BUKSocialKit'
  s.author   = { 'Lazy Clutch' => 'lr_5146@163.com' }
  s.source   = { :git => 'https://github.com/iException/BUKSocialKit.git', :tag => '0.0.5' }
  s.platform = :ios, '7.0'
  s.source_files = 'BUKSocialKit/**/*.{h,m}'
  s.resource     = 'BUKSocialKit/WeiboSDK.bundle', 'BUKSocialKit/TencentOpenApi_IOS_Bundle.bundle'
  s.frameworks = 'UIKit', 'Foundation', 'ImageIO', 'SystemConfiguration', 'CoreText', 'QuartzCore', 'Security', 'Foundation', 'CoreGraphics','CoreTelephony'
  s.libraries = 'sqlite3', 'z', 'iconv', 'stdc++'
  s.vendored_libraries  = 'BUKSocialkit/libWeiboSDK.a', 'BUKSocialkit/libWeChatSDK.a'
  s.vendored_frameworks = 'BUKSocialkit/TencentOpenAPI.framework'
  s.requires_arc = true
end
