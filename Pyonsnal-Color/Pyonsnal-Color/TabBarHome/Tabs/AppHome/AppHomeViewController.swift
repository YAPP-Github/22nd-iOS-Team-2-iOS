//
//  AppHomeViewController.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs
import UIKit

protocol AppHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppHomeViewController: UIViewController,
                                   AppHomePresentable,
                                   AppHomeViewControllable {

    weak var listener: AppHomePresentableListener?
    
    init() {
      super.init(nibName: nil, bundle: nil)
      
      setupViews()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setupViews()
    }
    
    private func setupViews() {
      title = "홈"
      tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
      view.backgroundColor = .red
    }
}
