Pod::Spec.new do |s|
  s.name     = 'BUKSocialKit'
  s.version  = '0.0.6'
  s.license  = 'MIT'
  s.summary  = 'Baixing Social Share Kit'
  s.homepage = 'https://github.com/iException/BUKSocialKit'
  s.author   = { 'Lazy Clutch' => 'lr_5146@163.com' }
  s.source   = { :git => 'https://github.com/iException/BUKSocialKit.git', :tag => '0.0.6' }
  s.platform = :ios, '7.0'
  s.source_files = 'BUKSocialKit/**/*.{h,m}'
  s.requires_arc = true
  s.static_framework = true
  s.dependency 'BXTencentOpenAPI'
  s.dependency 'WechatOpenSDK'
  s.dependency 'WeiboSDK'
end
