//
//  ANTabBar.swift
// 
//
//  Created by Massimiliano on 22/03/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit

open class ANMoovableView: UIView {
    @IBOutlet var topConstraint: NSLayoutConstraint?
    @IBOutlet var bottomConstraint: NSLayoutConstraint?
    @IBOutlet var heigthConstraint: NSLayoutConstraint?
}

open class ANTabBar: ANMoovableView {
    
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet weak var fakeLbl: UILabel?
    var contentView: UIView?
    var didSelectIndex: ((_ index: Int) -> () )?

    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setupIntrinsictConstraint()
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.stackView?.distribution = .fillEqually
        }
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.add(subview: view, margin: .zero)
        contentView = view
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: "ANTabBar", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    
    func addItem(item: ANTabBarItem) {
        self.stackView?.addArrangedSubview(item)
        item.addTarget(self, action: #selector(selectItem(sender:)), for: .touchUpInside)
    }
    
    func selectIndex(index: Int, animated: Bool = true)  {
        self.selectItem(sender: self.stackView?.arrangedSubviews[index] as! ANTabBarItem, animated: animated)
    }
    

    func getButtonItemAtIndex(index: Int) -> ANTabBarItem? {
        return self.stackView?.arrangedSubviews[index] as? ANTabBarItem
    }
    
    
    @objc func selectItem(sender: ANTabBarItem) {
        self.selectItem(sender: sender, animated: true)
        for i in 0 ..< (self.stackView?.arrangedSubviews.count ?? 0) {
            if self.stackView?.arrangedSubviews[i] == sender {
                self.didSelectIndex?(i)
            }
        }

    }
    
    func selectItem(sender: ANTabBarItem, animated: Bool)  {
        self.fakeLbl?.font = sender.titleLbl?.font
        self.fakeLbl?.text = sender.title
        self.fakeLbl?.superview?.layoutIfNeeded()
        
        let newFramew = (self.fakeLbl?.superview?.frame.size.width ?? 0.0 )
        sender.setSelected(selected: true, animated: animated, width: newFramew)
        
        let proporionalSpace: CGFloat = (self.stackView!.frame.size.width - newFramew)/4
        
        
        for item in self.stackView?.arrangedSubviews ?? [] {
            if let item = item as? ANTabBarItem, item != sender  {
                item.setSelected(selected: false, animated: animated, width: proporionalSpace)
            }
        }
    }
    
    func setupIntrinsictConstraint() {
        var bottomInset: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomInset = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
        }
        self.heigthConstraint?.constant = ANTabBarController.defaultBarHeight + bottomInset
        self.bottomConstraint?.constant = 0
        self.superview?.layoutIfNeeded()
    }
    
    
    func constract(animated: Bool) {
        self.bottomConstraint?.constant = -(self.heigthConstraint?.constant ?? 0)
        UIView.animate(withDuration: ANTabBarController.animationTime) {
            self.alpha = 0
        }
        UIView.animate(withDuration: ANTabBarController.animationTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut
            , animations: {
                self.superview?.layoutIfNeeded()
        }, completion: { (finish) in
            
        })
    }
    
    func expand(animated: Bool) {
        self.bottomConstraint?.constant =  0
        UIView.animate(withDuration: ANTabBarController.animationTime) {
            self.alpha = 1
        }
        UIView.animate(withDuration: ANTabBarController.animationTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut
            , animations: {
                self.superview?.layoutIfNeeded()
        }, completion: { (finish) in
            
        })
    }
}


