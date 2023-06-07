//
//  EventHomeViewController.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs
import UIKit

protocol EventHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class EventHomeViewController: UIViewController, EventHomePresentable, EventHomeViewControllable {

    weak var listener: EventHomePresentableListener?
    
    init() {
      super.init(nibName: nil, bundle: nil)
      
      setupViews()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      setupViews()
    }
    
    private func setupViews() {
      title = "이벤트"
      tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(systemName: "square.and.arrow.up"), selectedImage: UIImage(systemName: "square.and.arrow.up.fill"))
      view.backgroundColor = .systemPink
    }
}
