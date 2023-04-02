//
//  FDSecondaryButton.swift
//  FDUI
//
//  Created by Alief Ahmad Azies on 27/03/23.
//

import UIKit

@IBDesignable
public class FDSecondaryButton: UIButton {

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    @IBInspectable public var color: UIColor = UIColor(rgb: 0xFC6011) {
        didSet {
            update()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.clear
        
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        layer.masksToBounds = true
        layer.borderWidth = 1
        
        update()
    }
    
    func update() {
        setTitleColor(color, for: .normal)
        layer.cornerRadius = cornerRadius
        layer.borderColor = color.cgColor
    }
    
}
