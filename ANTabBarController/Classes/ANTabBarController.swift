//
//  AnimatedTabBar.swift
//  
//
//  Created by Massimiliano on 22/03/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit


open class ANTabBarController: UIViewController {
    
    public static let animationTime: TimeInterval = 0.65
    public static let defaultBarHeight: CGFloat = 50
    
    @IBOutlet weak var tabBar: ANTabBar?
    @IBOutlet weak var contentView: UIView?
    
    open weak var currentViewController: UIViewController?
    
    private var shouldResetSelectedItem: Bool = true
    
    override open var childForStatusBarStyle: UIViewController? {
        return self.currentViewController
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self.currentViewController?.preferredStatusBarStyle ?? .lightContent
        }
    }
    
    var isOpen: Bool = false
    public var viewControllers: [UIViewController] = [] {
        didSet {
            self.showViewController(atIndex: 0)
        }
    }
    
    public static func create() -> ANTabBarController {
        
        return UIStoryboard(name: "ANTabBarController", bundle: Bundle(for: ANTabBarController.self)).instantiateInitialViewController() as! ANTabBarController
    }

    public func setBackgroudColor(_ color: UIColor) {
        self.tabBar?.backgroundColor = .white
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.showViewController(atIndex: 0)
        self.tabBar?.didSelectIndex = { [weak self] (index: Int) in
            self?.showViewController(atIndex: index)
        }
    }
    
    open func showViewController(atIndex index: Int, forceTabBarRefresh: Bool = false) {
        if index < self.viewControllers.count {
            self.currentViewController?.view.removeFromSuperview()
            self.currentViewController?.removeFromParent()
            self.currentViewController = self.viewControllers[index]
            self.contentView?.add(subview: self.currentViewController!.view, margin: .zero)
            self.addChild(self.currentViewController!)
            self.setNeedsStatusBarAppearanceUpdate()
            if forceTabBarRefresh {
                self.tabBar?.selectIndex(index: index)
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldResetSelectedItem {
            self.tabBar?.selectIndex(index: 0, animated: false)
            shouldResetSelectedItem = false
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    open func addItem(viewController: UIViewController, title: String, tintColor: UIColor) {
        self.viewControllers.append(viewController)
        
    }
    
    open func add(viewController: UIViewController, item: ANTabBarItem) {
        self.viewControllers.append(viewController)
        self.tabBar?.addItem(item: item)
        
    }
    
}


internal extension UIView {
    func add(subview view: UIView , margin: UIEdgeInsets)  {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: margin.top))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: margin.right))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -margin.bottom))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -margin.left))
        self.layoutIfNeeded()
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = (newValue > 0)
            layer.cornerRadius = newValue
        }
    }
}
