//
//  ANTabBarItem.swift
//  
//
//  Created by Massimiliano on 22/03/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//
import UIKit

public class ANTabBarItem: UIControl {
    
    @IBOutlet weak var icon: UIImageView?
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var indicatorView: UIView?
    @IBOutlet weak var minimuMargin: NSLayoutConstraint?
    @IBOutlet weak var labelMarginRight: NSLayoutConstraint?
    @IBOutlet weak var bedgeView: UIView?
    
    var widthConstraint: NSLayoutConstraint?
    var iconImage: UIImage?
   
    public var title: String?
    public var selectedColor: UIColor = .red
    public var defaultColor: UIColor = .white
    
    public static func create(title: String, icon: UIImage?, defaultColor: UIColor = .white, selectedColor: UIColor = .red, font: UIFont = UIFont.boldSystemFont(ofSize: 16)) -> ANTabBarItem {
        let toReturn = self.create()
        toReturn.set(title: title, icon: icon, defaultColor: defaultColor, selectedColor: selectedColor, font: font)
        return toReturn
    }
    
    public static func create() -> ANTabBarItem {
        return Bundle(for: self).loadNibNamed("ANTabBarItem", owner: nil, options: nil)?.first as! ANTabBarItem
    }
    
    public func set(title: String, icon: UIImage?, defaultColor: UIColor = .white, selectedColor: UIColor = .red, font: UIFont = UIFont.boldSystemFont(ofSize: 16)) {
        self.title = title
        self.titleLbl?.text = title
        self.titleLbl?.font = font
        self.titleLbl?.textColor = defaultColor
        self.iconImage = icon
        self.icon?.image = icon
        self.indicatorView?.backgroundColor = selectedColor
        self.selectedColor = selectedColor
        self.defaultColor = defaultColor
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.titleLbl?.alpha = 0
        self.indicatorView?.alpha = 0
        self.widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        self.addConstraint(self.widthConstraint!)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.sendActions(for: .touchUpInside)
    }
    
    func setSelected( selected: Bool, animated: Bool, width: CGFloat? = nil) {
        self.isSelected = selected
        self.icon?.tintColor  = selected ?  defaultColor : selectedColor
        self.widthConstraint?.constant = width ?? 0
        self.minimuMargin?.priority = selected ? UILayoutPriority.defaultHigh : UILayoutPriority.defaultLow
        self.labelMarginRight?.constant = selected ? 10 : 0
        if animated {
            UIView.animate(withDuration: 0.23) {
                self.titleLbl?.alpha = selected ? 1 : 0
            }
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
                self.indicatorView?.alpha = selected ? 1 : 0
            }, completion: nil)
            
        } else {
            self.titleLbl?.alpha = selected ? 1 : 0
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            self.indicatorView?.alpha = selected ? 1 : 0
        }
        
    }
    
    
}
