//
//  FDRoundedView.swift
//  FDUI
//
//  Created by Alief Ahmad Azies on 18/08/23.
//

import UIKit

public class FDRoundedView: UIView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
