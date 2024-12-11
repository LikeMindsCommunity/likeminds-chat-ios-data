//
//  FirebaseServiceConfiguration.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 18/07/22.
//

import FirebaseCore
import FirebaseDatabase
import FirebaseMessaging
import Foundation

struct FirebaseServiceConfiguration {

    struct DevTestKeys {
        static let encodedGoogleAppID =
            "MTo5ODM2OTAzMDIzNzg6aW9zOjAwZWU1M2U5YWI5YWZlODUxYjkxZDM="
        static let encodedGcmSenderID = "OTgzNjkwMzAyMzc4"
        static let encodedProjectID = "Y29sbGFibWF0ZXMtYmV0YQ=="
        static let encodedBundleID = "Y29tLkNvbGxhYk1hdGVzLmFwcC5kZXY="
        static let encodedClientID =
            "OTgzNjkwMzAyMzc4LTBmMDdmMmlsamo1NGM2aTVpY3M3dTg1NjA5cDJ0NmdtLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29t"
        static let encodedDatabaseURL =
            "aHR0cHM6Ly9jb2xsYWJtYXRlcy1iZXRhLmZpcmViYXNlaW8uY29t"
        static let encodedStorageBucket =
            "Y29sbGFibWF0ZXMtYmV0YS5hcHBzcG90LmNvbQ=="
        static let encodedAndroidClientID = "OTgzNjkwMzAyMzc4LTRqMXE4OWVuNHExcGo5bTJpY2Yza3E5cDZndGNrdjFmLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29t"

        static var googleAppID: String { encodedGoogleAppID.fromBase64()! }
        static var gcmSenderID: String { encodedGcmSenderID.fromBase64()! }
        static var projectID: String { encodedProjectID.fromBase64()! }
        static var bundleID: String { encodedBundleID.fromBase64()! }
        static var clientID: String { encodedClientID.fromBase64()! }
        static var databaseURL: String { encodedDatabaseURL.fromBase64()! }
        static var storageBucket: String { encodedStorageBucket.fromBase64()! }
        static var androidClientID: String {
            encodedAndroidClientID.fromBase64()!
        }
    }

    // Encoded keys for DevTest environment
    struct ProductionKeys {
        static let encodedGoogleAppID =
            "MTo2NDU3MTY0NTg3OTM6aW9zOjIwYzMwNmE1NjNjNGM2ZWJhYzhiMzg="
        static let encodedGcmSenderID = "NjQ1NzE2NDU4Nzkz"
        static let encodedProjectID = "Y29sbGFibWF0ZXMtM2Q2MDE="
        static let encodedBundleID = "Y29tLkNvbGxhYk1hdGVzLmFwcA=="
        static let encodedClientID =
            "NjQ1NzE2NDU4NzkzLXZiZGVpMmVpOTgxc2hqNDBzajQ5dmw4a2o0OGJua2lhLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29t"
        static let encodedDatabaseURL =
            "aHR0cHM6Ly9jb2xsYWJtYXRlcy0zZDYwMS5maXJlYmFzZWlvLmNvbQ=="
        static let encodedStorageBucket =
            "Y29sbGFibWF0ZXMtM2Q2MDEuYXBwc3BvdC5jb20="
        static let encodedAndroidClientID = "NjQ1NzE2NDU4NzkzLTkwY2pxaDlwdTd1ZGYwcjdoZWFhNWRhbTJwYW1ibzN1LmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29t"

        static var googleAppID: String { encodedGoogleAppID.fromBase64()! }
        static var gcmSenderID: String { encodedGcmSenderID.fromBase64()! }
        static var projectID: String { encodedProjectID.fromBase64()! }
        static var bundleID: String { encodedBundleID.fromBase64()! }
        static var clientID: String { encodedClientID.fromBase64()! }
        static var databaseURL: String { encodedDatabaseURL.fromBase64()! }
        static var storageBucket: String { encodedStorageBucket.fromBase64()! }
        static var androidClientID: String {
            encodedAndroidClientID.fromBase64()!
        }
    }

    private static let appName = "likemindschatsdk"

    static let firebaseDatabase: Database = {
        // Retrieve a previous created named app.
        guard let secondary = FirebaseApp.app(name: appName)
        else {
            assert(false, "Could not retrieve secondary app")
            return Database.database()
        }
        // Retrieve a Real Time Database client configured against a specific app.
        return Database.database(app: secondary)
    }()

    static func setupFirebaseAppService() {
        switch BuildManager.environment {
        case .devtest:
            setupFirebaseBetaService()
            break
        case .production:
            setupFirebaseProdService()
            break
        }
    }

    private static func setupFirebaseBetaService() {
        // Configure with manual options. Note that projectID and apiKey, though not
        // required by the initializer, are mandatory.
        let secondaryOptions = FirebaseOptions(
            googleAppID: DevTestKeys.googleAppID,
            gcmSenderID: DevTestKeys.gcmSenderID
        )
        secondaryOptions.apiKey = ServiceConfiguration.firebaseApiKey
        secondaryOptions.projectID = DevTestKeys.projectID
        // The other options are not mandatory, but may be required
        // for specific Firebase products.
        secondaryOptions.bundleID = DevTestKeys.bundleID
        secondaryOptions.clientID =
            DevTestKeys.clientID
        secondaryOptions.databaseURL = DevTestKeys.databaseURL
        secondaryOptions.storageBucket = DevTestKeys.storageBucket
        secondaryOptions.androidClientID =
            DevTestKeys.androidClientID
        secondaryOptions.appGroupID = nil
        // Configure an alternative FIRApp.
        FirebaseApp.configure(name: appName, options: secondaryOptions)
    }

    private static func setupFirebaseProdService() {
        // Configure with manual options. Note that projectID and apiKey, though not
        // required by the initializer, are mandatory.
        let secondaryOptions = FirebaseOptions(
            googleAppID: ProductionKeys.googleAppID,
            gcmSenderID: ProductionKeys.gcmSenderID
        )
        secondaryOptions.apiKey = ServiceConfiguration.firebaseApiKey
        secondaryOptions.projectID = ProductionKeys.projectID
        // The other options are not mandatory, but may be required
        // for specific Firebase products.
        secondaryOptions.bundleID = ProductionKeys.bundleID
        secondaryOptions.clientID =
            ProductionKeys.clientID
        secondaryOptions.databaseURL =
            ProductionKeys.databaseURL
        secondaryOptions.storageBucket = ProductionKeys.storageBucket
        secondaryOptions.androidClientID =
            ProductionKeys.androidClientID
        secondaryOptions.appGroupID = nil
        // Configure an alternative FIRApp.
        FirebaseApp.configure(name: appName, options: secondaryOptions)
    }

    static func getDatabaseReferenceForConversation(_ chatRoomID: String?)
        -> DatabaseReference?
    {
        guard let chatRoomID else { return nil }
        let ref = FirebaseServiceConfiguration.firebaseDatabase
            .reference()
            .child("collabcards")
            .child(chatRoomID)
        ref.keepSynced(true)
        return ref
    }

    static func getDatabaseReferenceForHomeFeed(_ communityId: String)
        -> DatabaseReference?
    {
        let ref = FirebaseServiceConfiguration.firebaseDatabase
            .reference()
            .child("community")
            .child(communityId)
        ref.keepSynced(true)
        return ref
    }
}
