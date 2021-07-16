Pod::Spec.new do |s|
  s.name             = 'Emitter'
  s.version          = '1.0.0'
  s.summary          = 'Emitter: Distributed Publish-Subscribe Platform'
  s.description      = 'inspire by emitter.io & eventbus'
  s.homepage         = 'https://github.com/tangbl93/Emitter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tangbl93' => 'tangbl93@gmail.com' }
  s.source           = { :git => 'https://github.com/tangbl93/Emitter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'Emitter/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/Emitter.h'
  
end
