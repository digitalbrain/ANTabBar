//
//  AnimatedTabBar.swift
//  
//
//  Created by Massimiliano on 22/03/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit
import DBCommonUI


public class ANTabBarController: UIViewController {
    
    static let animationTime: TimeInterval = 0.65
    static let defaultBarHeight: CGFloat = 50
    
    @IBOutlet weak var tabBar: ANTabBar?
    @IBOutlet weak var menuBtn: UIButton?
    @IBOutlet weak var arrowBtn: UIButton?
    @IBOutlet weak var menuBtnContainer: UIView?
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var alphaView: UIView?
    
    public weak var currentViewController: UIViewController?
    
    private var shouldResetSelectedItem: Bool = true
    
    override public var childForStatusBarStyle: UIViewController? {
        return self.currentViewController
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupInitialState()
        self.arrowBtn?.alpha = 0
        self.menuBtn?.alpha = 1
        self.hideBottomBar()
        self.showViewController(atIndex: 0)
        self.tabBar?.didSelectIndex = { [weak self] (index: Int) in
            self?.showViewController(atIndex: index)
        }
    }
    
    public func showViewController(atIndex index: Int, forceTabBarRefresh: Bool = false) {
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
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldResetSelectedItem {
            self.tabBar?.selectIndex(index: 0, animated: false)
            shouldResetSelectedItem = false
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    public func hideBottomBar(animated: Bool = false)  {
        if animated {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.tabBar?.hideOutOfScreen()
            }, completion: nil)
        } else {
            self.tabBar?.hideOutOfScreen()
        }
    }
    
    public func showBottomBar(animated: Bool = false)  {
        if animated {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.tabBar?.setupIntrinsictConstraint()
            }, completion: nil)
        } else {
            self.tabBar?.setupIntrinsictConstraint()
        }
        
    }
    
    func addItem(viewController: UIViewController, title: String, tintColor: UIColor) {
        self.viewControllers.append(viewController)
        
    }
    

    func setupInitialState()  {
        /*self.tabBar?.addItem(title: "Home", defaultIcon: UIImage(named: "ico-home-g"), selectedIcon: UIImage(named: "ico-home-b"))
        self.tabBar?.addItem(title: "Promemoria", defaultIcon: UIImage(named: "ico-categorie-g"), selectedIcon: UIImage(named: "ico-category-sel"))
        self.tabBar?.addItem(title: "Preferiti", defaultIcon: UIImage(named: "ico-carrello-g"), selectedIcon: UIImage(named: "ico-cart-b"))
        self.tabBar?.addItem(title: "Impostazioni", defaultIcon: UIImage(named: "ico-negozi-g"), selectedIcon: UIImage(named: "ico-negozi-b"))
    */
    }
  
    public func add(viewController: UIViewController, item: ANTabBarItem) {
        self.viewControllers.append(viewController)
        self.tabBar?.addItem(item: item)
        
    }
    
}
