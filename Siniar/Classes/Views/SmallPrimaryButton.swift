//
//  SmallPrimaryButton.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 02/08/22.
//

import UIKit

class SmallPrimaryButton: PrimaryButton {

    override func setup() {
        super.setup()
        
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
