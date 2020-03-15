//
//  NamesViewController.swift
//  SkillBox14
//
//  Created by itsec on 15.03.2020.
//  Copyright © 2020 itsec. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let name = PersistanceNames.shared.name else { return }
        guard let lastName = PersistanceNames.shared.lastName else { return }
        nameLabel.text = "\(name) \(lastName)"
    }
    

    @IBAction func saveButton(_ sender: Any) {
        guard let name = nameTF.text else { return }
        guard let lastName = lastNameTF.text else { return }
        PersistanceNames.shared.name = name
        PersistanceNames.shared.lastName = lastName
        
        nameLabel.text = "\(PersistanceNames.shared.name!) \(PersistanceNames.shared.lastName!)"
        
    }
    

}
