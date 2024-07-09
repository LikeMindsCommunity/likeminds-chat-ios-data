# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'LikeMindsChat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LikeMindsChat
  pod 'Alamofire', '~> 5.7'
  pod 'RealmSwift', '~>10.40'
  pod 'FirebaseCore'
  pod 'FirebaseMessaging'
  pod 'FirebaseDatabase'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
