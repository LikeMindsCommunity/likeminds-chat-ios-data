# 1 - Pod Install
pod deintegrate
rm -rf Podfile.lock
pod install

# 2 - Cleaning the workspace
xcodebuild clean -workspace LikeMindsChat.xcworkspace -scheme LikeMindsChat

# 3 - Building the workspace
xcodebuild build -workspace LikeMindsChat.xcworkspace -scheme LikeMindsChat

# 4 - Archiving the workspace for Device
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-configuration Release \
-sdk iphoneos \
-archivePath LMChatFramework/archives/ios_devices.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \

# 5 - Archiving the workspace for Simulators
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-configuration Debug \
-sdk iphonesimulator \
-archivePath LMChatFramework/archives/ios_simulators.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \

# 6 - Creating `.xcframework` 
xcodebuild \
-create-xcframework \
-framework LMChatFramework/archives/ios_devices.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-framework LMChatFramework/archives/ios_simulators.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-output LMChatFramework/LikeMindsChat.xcframework
