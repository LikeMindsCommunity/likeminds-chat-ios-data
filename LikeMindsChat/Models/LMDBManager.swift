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
    static private func dbConfig() -> Realm.Configuration {
        let username = "LMChatDB"
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(username)
        config.fileURL!.appendPathExtension("realm")
        config.schemaVersion = 6
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

        }
        return config
    }

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
    /// write operation
    static func write<T: Object>(
        _ object: T?, block: @escaping ((Realm, T?) -> Void))
    ///
    /// adds a single object to Realm
    static func add(_ object: Object)
    /// adds a list of objects to Realm
    static func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object

    /// gets objects from Realm that satisfy the given predicate
    static func get<R: Object>(
        fromEntity entity: R.Type, withPredicate predicate: NSPredicate?,
        sortedByKey sortKey: String?, inAscending isAscending: Bool
    ) -> Results<R>

    /// deletes a single object from Realm
    static func delete(_ object: Object)

    /// deletes a list of object from Realm
    static func delete<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object

    /// deletes an Entity from Realm based  on the given predicate
    static func delete(
        fromEntity entity: Object.Type, withPredicate predicate: NSPredicate?)

    /// updates and overwrites a Realm object
    static func update<T: Object>(_ object: T, block: @escaping ((T) -> Void))
}

extension LMDBManager: RealmOperations {
    /// Writes to Realm
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

    // MARK:- ADD functions
    /// adds an object to Realm
    static func add(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }

    /// adds a list of objects to Realm
    static func add<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }

    // MARK:- GET function
    static func get<R: Object>(
        fromEntity entity: R.Type, withPredicate predicate: NSPredicate? = nil,
        sortedByKey sortKey: String? = nil, inAscending isAscending: Bool = true
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

    // MARK:- DELETE functions
    static func delete(_ object: Object) {
        Self.write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.delete(newObject)
        }
    }

    /// deletes a list of elements from Realm
    static func delete<S: Sequence>(_ objects: S)
    where S.Iterator.Element: Object {
        Self.write { (realmInstance, _) in
            realmInstance.delete(objects)
        }
    }

    /// deletes an Entity from Realm, a predicate can be given
    static func delete(
        fromEntity entity: Object.Type,
        withPredicate predicate: NSPredicate? = nil
    ) {
        Self.delete(Self.get(fromEntity: entity, withPredicate: predicate))
    }

    // MARK:- UPDATE function
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

    // MARK:- insert Or Update function
    static func insertOrUpdate(_ object: Object) {
        Self.write { (realmInstance, _) in
            realmInstance.add(object, update: .modified)
        }
    }
}
