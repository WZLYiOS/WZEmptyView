
Pod::Spec.new do |s|
  s.name             = 'WZEmptyView'
  s.version          = '3.0.0'
  s.summary          = '我主良缘空视图加载View'
  s.homepage         = 'https://github.com/WZLYiOS/WZEmptyView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZEmptyView.git', :tag => s.version.to_s }

  
  s.requires_arc = true
  s.static_framework = true
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Source'
  
  
  s.subspec 'Source' do |ss|
    ss.source_files = 'WZEmptyView/Classes/*.swift'
  end


#  s.subspec 'Binary' do |ss|
#    ss.vendored_frameworks = "Carthage/Build/iOS/Static/WZEmptyView.framework"
#    ss.user_target_xcconfig = { 'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)' }

#  end
end
