
# 1
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-configuration Release \
-sdk iphoneos \
-archivePath LMChatFramework/archives/ios_devices.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \

# 2
xcodebuild archive \
-workspace LikeMindsChat.xcworkspace \
-scheme LikeMindsChat \
-configuration Debug \
-sdk iphonesimulator \
-archivePath LMChatFramework/archives/ios_simulators.xcarchive \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
SKIP_INSTALL=NO \

# 3
xcodebuild \
-create-xcframework \
-framework LMChatFramework/archives/ios_devices.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-framework LMChatFramework/archives/ios_simulators.xcarchive/Products/Library/Frameworks/LikeMindsChat.framework \
-output LMChatFramework/LikeMindsChat.xcframework
