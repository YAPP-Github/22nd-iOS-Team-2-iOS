//
//  LoggedInRouter.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import UIKit
import ModernRIBs

protocol LoggedInInteractable: Interactable, TabBarHomeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(_ viewController: UIViewController)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    private var tabBarHomeBuilder: TabBarHomeBuildable
    private var tabBarHomeRouting: TabBarHomeRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         tabBarHomeBuilder: TabBarHomeBuilder) {
        self.viewController = viewController
        self.tabBarHomeBuilder = tabBarHomeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    
    func attachTabBarHomeRiB() {
        if tabBarHomeRouting != nil { return }
        let tabBarHomeRouter = tabBarHomeBuilder.build(withListener: interactor)        
        viewController.present(tabBarHomeRouter.viewControllable, animated: true, completion: nil)
        self.tabBarHomeRouting = tabBarHomeRouter
        attachChild(tabBarHomeRouter)
    }
}
