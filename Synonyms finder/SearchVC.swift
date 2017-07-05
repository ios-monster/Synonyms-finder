//
//  ViewController.swift
//  Synonyms finder
//
//  Created by Ashot on 6/24/17.
//  Copyright © 2017 ios.monster. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
  
  @IBOutlet var searchTF: UITextField!
  
  var synonym:Synonym?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchVC.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: animated);
    super.viewWillDisappear(animated)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  @IBAction func searchBtnTapped(_ sender: Any) {
    
    // text field is empty
    if searchTF.text?.isEmpty == true {
      let alert = UIAlertController(title: "Error", message: "Text field is empty", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    } else {
      
      // try to get all synonyms
      let trimmedString = searchTF.text?.trimmingCharacters(in: .whitespaces)
      let restApiservice = RestApiService()
      restApiservice.getSynonymsToWord(word: trimmedString!) { (result) in
        if let error = result.error {
          let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
        let synonym = result.value
        self.synonym = synonym
        self.performSegue(withIdentifier: "toSearchDetailVC", sender: sender)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSearchDetailVC" {
      let searchDeatilVC = segue.destination as! SearchDetailVC
      searchDeatilVC.synonym = self.synonym
    }
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}














