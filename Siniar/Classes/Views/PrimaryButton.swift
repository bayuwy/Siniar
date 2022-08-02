//
//  PrimaryButton.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 02/08/22.
//

import UIKit

class PrimaryButton: UIButton {
    convenience init() {
        self.init(type: .system)
        setup()
    }
    
    func setup() {
        tintColor = UIColor.Siniar.neutral3
        backgroundColor = UIColor.Siniar.brand1
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
}
