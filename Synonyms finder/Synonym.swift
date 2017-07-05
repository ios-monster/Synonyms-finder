//
//  Synonym.swift
//  Synonyms finder
//
//  Created by Ashot on 6/24/17.
//  Copyright © 2017 ios.monster. All rights reserved.
//

import Foundation
import RealmSwift

class SynonymRealm:Object {
  
  dynamic var word = ""
  let synonyms = List<SynonymText>()
  
  override static func primaryKey() -> String? {
    return "word"
  }
  
  convenience init(synonym:Synonym) {
    self.init()
    
    if let word = synonym.word {
      self.word = word
    }
    
    if let allSynonyms = synonym.synonyms {
      for syn in allSynonyms {
        let synonym = SynonymText()
        synonym.text = syn
        self.synonyms.append(synonym)
      }
    }
  }
}

class SynonymText:Object {
  dynamic var text = ""
}

class Synonym {
  
  var word:String?
  var synonyms:[String]?
  
  init(word:String,json:[String:AnyObject]) {
    self.word = word
    var allSynonyms = [String]()
    
    if let noun = json["noun"] {
      let synonyms = noun["syn"] as! [String]
      for syn in synonyms {
        allSynonyms.append(syn)
      }
    }
    if let adverb = json["adverb"] {
      let synonyms = adverb["syn"] as! [String]
      for syn in synonyms {
        allSynonyms.append(syn)
      }
    }
    if let verb = json["verb"] {
      let synonyms = verb["syn"] as! [String]
      for syn in synonyms {
        allSynonyms.append(syn)
      }
    }
    if let adjective = json["adjective"] {
      let synonyms = adjective["syn"] as! [String]
      for syn in synonyms {
        allSynonyms.append(syn)
      }
    }
    self.synonyms = allSynonyms
  }
  
  class func saveSynonym(syn:Synonym) {
    let synonym = SynonymRealm(synonym: syn)
    let realm = try! Realm()
    try! realm.write {
      realm.add(synonym)
    }
  }
}




