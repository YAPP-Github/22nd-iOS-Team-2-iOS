//
//  ProfileHomeViewController.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs
import UIKit

protocol ProfileHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ProfileHomeViewController: UIViewController,
                                        ProfileHomePresentable,
                                       ProfileHomeViewControllable {

    weak var listener: ProfileHomePresentableListener?
    
    init() {
      super.init(nibName: nil, bundle: nil)
      
      setupViews()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      setupViews()
    }
    
    private func setupViews() {
      title = "프로파일"
      tabBarItem = UITabBarItem(title: "프로파일", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
      view.backgroundColor = .brown
    }
}
