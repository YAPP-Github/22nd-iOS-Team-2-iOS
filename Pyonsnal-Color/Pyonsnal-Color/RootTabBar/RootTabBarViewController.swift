//
//  RootTabBarViewController.swift
//  Pyonsnal-Color
//
//  Created by 김인호 on 2023/06/10.
//

import ModernRIBs
import UIKit

protocol RootTabBarPresentableListener: AnyObject {
}

final class RootTabBarViewController:
    UITabBarController,
    RootTabBarPresentable,
    RootTabBarViewControllable {

    //MARK: - Property
    weak var listener: RootTabBarPresentableListener?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupTabBar()
    }
    
    //MARK: - Internal Method
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
    
    //MARK: - Private Method
    private func setupTabBar() {
        var tabFrame = tabBar.frame
        let tabBarHeight: CGFloat = .init(86)
        
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 16
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.applyShadow()
    }
}
