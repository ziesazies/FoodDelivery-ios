//
//  FDTextField.swift
//  FDUI
//
//  Created by Alief Ahmad Azies on 27/03/23.
//

import UIKit

@IBDesignable public class FDTextField: UITextField {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
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
        backgroundColor = UIColor(rgb: 0xF2F2F2)
        
        font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        layer.masksToBounds = true
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
    }
        
}
