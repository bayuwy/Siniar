//
//  AccountViewController.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 06/08/22.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        title = "Account"
        
        let textField = UITextField(frame: .zero)
        view.addSubview(textField)
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
