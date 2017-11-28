//
//  ViewController.swift
//  HelloWorld
//
//  Created by Manikandan K on 28/11/17.
//  Copyright © 2017 Manikandan K. All rights reserved.
//

import UIKit

@IBDesignable
class HWInspectableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
    }

}
