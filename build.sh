pod deintegrate

pod install

# 4 - Archiving the workspace for Device
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-destination "generic/platform=iOS" \
-sdk iphoneos \
-archivePath LMChatFramework/archives/ios_devices.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
ONLY_ACTIVE_ARCH=NO \
SKIP_INSTALL=NO \

# 5 - Archiving the workspace for Simulators
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-destination "generic/platform=iOS Simulator" \
-sdk iphonesimulator \
-archivePath LMChatFramework/archives/ios_simulators.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
ONLY_ACTIVE_ARCH=NO \
SKIP_INSTALL=NO \

# 6 - Creating `.xcframework` 
xcodebuild \
-create-xcframework \
-framework LMChatFramework/archives/ios_devices.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-framework LMChatFramework/archives/ios_simulators.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-output LMChatFramework/LikeMindsChat.xcframework
