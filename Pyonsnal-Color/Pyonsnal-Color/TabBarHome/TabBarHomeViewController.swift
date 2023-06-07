//
//  TabBarHomeViewController.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs
import UIKit

protocol TabBarHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TabBarHomeViewController: UITabBarController,
                                      TabBarHomePresentable,
                                      TabBarHomeViewControllable {

    weak var listener: TabBarHomePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
      super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
}
