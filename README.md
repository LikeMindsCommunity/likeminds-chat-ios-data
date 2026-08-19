# LikeMinds Chat data layer for iOS

The Swift data layer behind the LikeMinds Chat SDK. Auth, networking, realtime sync, offline cache
and media upload.

[![CocoaPods](https://img.shields.io/cocoapods/v/LikeMindsChatData.svg)](https://cocoapods.org/pods/LikeMindsChatData)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

**Docs:** https://docs.likeminds.io/

## Install

```ruby
pod 'LikeMindsChatData', '~> 1.9.1'
```

Prefer a binary? A prebuilt xcframework is at
[likeminds-chat-ios-data-xc](https://github.com/LikeMindsCommunity/likeminds-chat-ios-data-xc).

## What it gives you

`LMChatClient`, plus **Realm persistence** and a full offline sync engine. `SyncOperations/` covers
first-time and reopen sync for both chatrooms and conversations, along with incremental database
sync.

Realtime conversation updates arrive over Firebase Realtime Database.

You can use this on its own to build your own chat UI. If you want screens too, use the
[UI SDK](https://github.com/LikeMindsCommunity/likeminds-chat-ios), which depends on this.

## Requirements

iOS 13.0+ · Swift 5 · CocoaPods only

## Built on

Alamofire · Realm · Firebase

## Contributing

See the org-wide [contributing guide](https://github.com/LikeMindsCommunity/.github/blob/master/.github/CONTRIBUTING.md).
Security issues go to **hi@likeminds.community**, not the issue tracker.

## License

Apache 2.0. See [LICENSE](LICENSE).
