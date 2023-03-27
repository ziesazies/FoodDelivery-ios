//
//  FDSecondaryButton.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 27/03/23.
//

import UIKit

@IBDesignable
class FDSecondaryButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        
        setTitleColor(UIColor.primary, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.primary.cgColor
        
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
    }
    
}
