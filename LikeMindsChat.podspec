Pod::Spec.new do |spec|
  spec.name         = "LikeMindsChat"
  spec.summary      = "Data Layer for LikeMindsChat"
  spec.homepage     = 'https://likeminds.community/'
  spec.version      = "1.3.0"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors       = { 'pushpendrasingh' => 'pushpendra.singh@likeminds.community' }
  spec.source       = { :git => "https://github.com/LikeMindsCommunity/likeminds-chat-ios-data.git", :tag => spec.version }
#  spec.vendored_frameworks = "LikeMindsChatData.xcframework"
  
  spec.source_files = 'LikeMindsChat/**/*.swift'
  spec.resource_bundles = {
    'LikeMindsChat' => ['LikeMindsChat/*.{xcassets}']
  }

  spec.ios.deployment_target = '13.0'
  spec.swift_version = '5.0'
  spec.requires_arc = true

  spec.dependency 'Alamofire'
  spec.dependency 'RealmSwift', '~>10'
  spec.dependency "FirebaseCore"
  spec.dependency "FirebaseMessaging"
  spec.dependency "FirebaseDatabase"

end
