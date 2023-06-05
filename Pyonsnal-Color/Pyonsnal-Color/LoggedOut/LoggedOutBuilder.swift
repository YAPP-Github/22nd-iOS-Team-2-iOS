//
//  LoggedOutBuilder.swift
//  Pyonsnal-Color
//
//  Created by 김진우 on 2023/05/28.
//

import ModernRIBs

protocol LoggedOutDependency: Dependency {
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
}

// MARK: - Builder
protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let _: LoggedOutComponent = .init(dependency: dependency)
        let viewController: LoggedOutViewController = .init()
        let interactor: LoggedOutInteractor = .init(presenter: viewController,
                                                    appleLoginService: AppleLoginService())
        interactor.listener = listener

        let router: LoggedOutRouter = .init(interactor: interactor, viewController: viewController)
        return router
    }
}
