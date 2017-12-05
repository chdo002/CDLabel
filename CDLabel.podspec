
Pod::Spec.new do |s|
  s.name             = 'CDLabel'
  s.version          = '0.0.12'
  s.summary          = '适用于聊天气泡中的label.'
  s.description      = '一种简单的富文本label，包括图片 链接 文字'
  s.homepage         = 'https://github.com/chdo002/CDLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chdo002' => '1107661983@qq.com' }
  s.source           = { :git => 'http://git-ma.paic.com.cn/aat/Label_iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'CDLabel/Classes/**/*'
  s.public_header_files = 'CDLabel/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreText'
end
