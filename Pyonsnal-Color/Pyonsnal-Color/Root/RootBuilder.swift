//
//  RootBuilder.swift
//  Pyonsnal-Color
//
//  Created by 김진우 on 2023/05/29.
//

import ModernRIBs

protocol RootDependency: Dependency {
}

final class RootComponent: Component<RootDependency> {
    var rootViewController: RootViewController
    var appleLoginService: AppleLoginService
    
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.appleLoginService = AppleLoginService()
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController: RootViewController = .init()
        let component: RootComponent = .init(dependency: dependency,
                                             rootViewController: viewController)
        let interactor: RootInteractor = .init(presenter: viewController)

        let loggedOutBuilder: LoggedOutBuilder = .init(dependency: component)
        let loggedInBuilder: LoggedInBuilder = .init(dependency: component)
        let router: RootRouter = .init(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOutBuilder,
            loggedInBuilder: loggedInBuilder
        )

        return router
    }
}
