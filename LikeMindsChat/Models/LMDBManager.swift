//
//  LMDBManager.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 08/01/24.
//

import Foundation
import RealmSwift

extension Results {
    var list: List<Element> {
        reduce(.init()) { list, element in
            list.append(element)
            return list
        }
    }
}

extension Realm {
    func insertOrUpdate(_ object: Object) {
        self.add(object, update: .modified)
    }
}

class LMDBManager {

    // MARK:- functions

    /// Configures and returns a Realm database configuration
    /// - Returns: A Realm.Configuration object with specified settings
    ///   - Username set to "LMChatDB"
    ///   - Schema version set to 7
    ///   - Migration block to handle schema updates
    /// - Note: Handles migrations for schema versions up to 7, including updates to MemberRO, UserRO, ConversationRO, LastConversationRO, WidgetRO, and AttachmentRO
    static private func dbConfig() -> Realm.Configuration {
        let username = "LMChatDB"
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(username)
        config.fileURL!.appendPathExtension("realm")
        config.schemaVersion = 7
        config.migrationBlock = { (migration, oldSchemaVersion) in
            let oldVersion = oldSchemaVersion

            if oldVersion <= 4 {
                migration.enumerateObjects(ofType: MemberRO.className()) {
                    old, new in
                    new?["roles"] = List<String>()

                }

                migration.enumerateObjects(ofType: UserRO.className()) {
                    old, new in
                    new?["roles"] = List<String>()
                }
            }
            if oldVersion <= 5 {
                migration.enumerateObjects(ofType: ConversationRO.className()) {
                    oldObject, newObject in
                    // Add default value for `widgetId`
                    newObject?["widgetId"] = nil  // Or provide a default value if necessary
                    newObject?["widget"] = nil
                }
                migration.enumerateObjects(
                    ofType: LastConversationRO.className()
                ) {
                    oldObject, newObject in
                    // Add default value for `widgetId`
                    newObject?["widgetId"] = nil  // Or provide a default value if necessary
                    newObject?["widget"] = nil
                }

                // Migrate WidgetRO to handle `_lm_meta` type change
                migration.enumerateObjects(ofType: WidgetRO.className()) {
                    oldObject, newObject in
                    newObject?["_lm_meta"] = nil
                }
            }
            if oldSchemaVersion <= 6 {
                migration.enumerateObjects(ofType: AttachmentRO.className()) {
                    oldObject, newObject in
                    newObject?["isUploaded"] = false  // Set a default value
                }
                migration.enumerateObjects(ofType: ConversationRO.className()) {
                    oldWidget, newObject in
                    newObject?["attachmentUploadedEpoch"] = nil
                }
                migration.enumerateObjects(
                    ofType: LastConversationRO.className()
                ) { oldWidget, newObject in
                    newObject?["attachmentUploadedEpoch"] = nil
                }
            }

        }
        return config
    }

    /// Creates and returns a new Realm instance with the specified configuration
    /// - Returns: A configured Realm instance
    /// - Throws: Fatal error if unable to create Realm instance
    static func lmDBInstance() -> Realm {
        do {
            let newRealm = try Realm(configuration: dbConfig())
            return newRealm
        } catch {
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
}

private protocol RealmOperations {
    /// Performs a write operation on a Realm object
    /// - Parameters:
    ///   - object: Optional object to be written
    ///   - block: Closure containing the write operation to be performed
    static func write<T: Object>(
        _ object: T?, block: @escaping ((Realm, T?) -> Void))

    /// Adds a single object to Realm database
    /// - Parameter object: Object to be added
    static func add(_ object: Object)

    /// Adds multiple objects to Realm database
    /// - Parameter objects: Sequence of objects to be added
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object

    /// Retrieves objects from Realm database based on specified criteria
    /// - Parameters:
    ///   - entity: Type of entity to retrieve
    ///   - predicate: Optional NSPredicate for filtering results
    ///   - sortKey: Optional key to sort results by
    ///   - isAscending: Boolean indicating sort order (default: true)
    /// - Returns: Results<R> containing matching objects
    static func get<R: Object>(
        fromEntity entity: R.Type,
        withPredicate predicate: NSPredicate?,
        sortedByKey sortKey: String?,
        inAscending isAscending: Bool
    ) -> Results<R>

    /// Deletes a single object from Realm database
    /// - Parameter object: Object to be deleted
    static func delete(_ object: Object)

    /// Deletes multiple objects from Realm database
    /// - Parameter objects: Sequence of objects to be deleted
    static func delete<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object

    /// Deletes objects of a specific entity type matching the given predicate
    /// - Parameters:
    ///   - entity: Type of entity to delete
    ///   - predicate: Optional NSPredicate for filtering objects to delete
    static func delete(
        fromEntity entity: Object.Type, withPredicate predicate: NSPredicate?)

    /// Updates a Realm object using the provided block
    /// - Parameters:
    ///   - object: Object to be updated
    ///   - block: Closure containing the update operation
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void))
}

extension LMDBManager: RealmOperations {
    /// Performs a write transaction on the Realm database
    /// - Parameters:
    ///   - object: Optional object to be written
    ///   - block: Closure containing the write operation
    /// - Note: Executes on a dedicated dispatch queue to prevent concurrent write operations
    /// - Important: If a write transaction is already in progress, the operation will be skipped
    static func write<T: Object>(
        _ object: T? = nil, block: @escaping ((Realm, T?) -> Void)
    ) {
        DispatchQueue(label: "realm").sync {
            autoreleasepool {
                let currentRealm = lmDBInstance()
                if currentRealm.isInWriteTransaction {
                    return
                } else {
                    do {
                        try currentRealm.write {
                            block(currentRealm, object)
                        }
                    } catch {
                        return
                    }
                }
            }
        }
    }

    /// Adds a single object to the Realm database with update policy set to .all
    /// - Parameter object: Object to be added
    static func add(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }

    /// Adds multiple objects to the Realm database with update policy set to .all
    /// - Parameter objects: Sequence of objects to be added
    static func add<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }

    /// Retrieves objects from the Realm database based on specified criteria
    /// - Parameters:
    ///   - entity: Type of entity to retrieve
    ///   - predicate: Optional predicate for filtering results
    ///   - sortKey: Optional key to sort results by
    ///   - isAscending: Boolean indicating sort order (default: true)
    /// - Returns: Results<R> containing matching objects
    static func get<R: Object>(
        fromEntity entity: R.Type,
        withPredicate predicate: NSPredicate? = nil,
        sortedByKey sortKey: String? = nil,
        inAscending isAscending: Bool = true
    ) -> Results<R> {
        var objects = lmDBInstance().objects(entity)
        if predicate != nil {
            objects = objects.filter(predicate!)
        }
        if sortKey != nil {
            objects = objects.sorted(
                byKeyPath: sortKey!, ascending: isAscending)
        }

        return objects
    }

    /// Deletes a single object from the Realm database
    /// - Parameter object: Object to be deleted
    /// - Note: If the object is invalid, the deletion will be skipped
    static func delete(_ object: Object) {
        Self.write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.delete(newObject)
        }
    }

    /// Deletes multiple objects from the Realm database
    /// - Parameter objects: Sequence of objects to be deleted
    static func delete<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.delete(objects)
        }
    }

    /// Deletes objects of a specific entity type matching the given predicate
    /// - Parameters:
    ///   - entity: Type of entity to delete
    ///   - predicate: Optional predicate for filtering objects to delete
    static func delete(
        fromEntity entity: Object.Type,
        withPredicate predicate: NSPredicate? = nil
    ) {
        Self.delete(Self.get(fromEntity: entity, withPredicate: predicate))
    }

    /// Updates a Realm object using the provided block
    /// - Parameters:
    ///   - object: Object to be updated
    ///   - block: Closure containing the update operation
    /// - Note: If the object is invalid, the update will be skipped
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void)) {
        guard !object.isInvalidated else {
            return
        }

        Self.write(object) { (_, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            block(newObject)
        }
    }

    /// Inserts or updates an object in the Realm database with update policy set to .modified
    /// - Parameter object: Object to be inserted or updated
    static func insertOrUpdate(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .modified)
        }
    }
}
