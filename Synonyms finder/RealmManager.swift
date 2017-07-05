//
//  RealmManager.swift
//  Synonyms finder
//
//  Created by Ashot on 6/24/17.
//  Copyright © 2017 ios.monster. All rights reserved.
//

import Foundation
import RealmSwift


class RealmManager {
  
  let realm = try! Realm()
  
  // Delete local database
  func deleteAllObjects() {
    try! realm.write({
      realm.deleteAll()
    })
  }
  
  func deleteObjectOnIndex(syn:SynonymRealm) {
    try! realm.write {
      realm.delete(syn)
    }
  }
  // Save array of objects to database
  func saveObjects(objs: [Object]) {
    try! realm.write({
      // If update = true, objects that are already in the Realm will be
      // updated instead of added a new.
      realm.add(objs, update: true)
    })
  }
  
  func getObjects() -> [SynonymRealm]? {
    let synonymsObjects = realm.objects(SynonymRealm.self).toArray()
    return synonymsObjects
  }
  
  // Check if object already exist
  func checkObject(syn:Synonym) -> SynonymRealm? {
    let word = syn.word!
    let object = realm.object(ofType: SynonymRealm.self, forPrimaryKey: word)
    return object
  }
}

extension Results {
  
  func toArray() -> [T] {
    return self.map{$0}
  }
}

extension RealmSwift.List {
  
  func toArray() -> [T] {
    return self.map{$0}
  }
}


