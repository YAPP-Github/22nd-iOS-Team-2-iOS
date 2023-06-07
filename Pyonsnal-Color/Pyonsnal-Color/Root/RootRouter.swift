//
//  RootRouter.swift
//  Pyonsnal-Color
//
//  Created by 김진우 on 2023/05/29.
//

import ModernRIBs

protocol RootInteractable: Interactable,
                           LoggedOutListener,
                           LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // MARK: - Private Property
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOut: LoggedOutRouting?
    
    private let loggedInBuilder: LoggedInBuildable
    private var loggedIn: LoggedInRouting?

    // MARK: - Initializer
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loggedOutBuilder: LoggedOutBuildable,
        loggedInBuilder: LoggedInBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)

        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToLoggedOut()
    }

    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        attachChild(loggedOut)
        self.loggedOut = loggedOut
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    func routeToLoggedIn() {
        //detach loggedOut
        if let loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        
        //attach loggedIn
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
        self.loggedIn = loggedIn
    }
}
