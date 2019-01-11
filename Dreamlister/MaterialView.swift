//
//  MaterialView.swift
//  Dreamlister
//
//  Created by Kyle Thompson on 11/19/16.
//  Copyright © 2016 KTinc. All rights reserved.
//

import UIKit

private var _materialKey = false

extension UIView {
    @IBInspectable var materialDesign: Bool {
        get {
            return _materialKey
        }
        set {
            _materialKey = newValue
            
            if _materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor.init(red: 70, green: 81, blue: 204).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
