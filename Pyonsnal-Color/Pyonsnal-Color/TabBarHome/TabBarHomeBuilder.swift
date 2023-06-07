//
//  TabBarHomeBuilder.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs

protocol TabBarHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TabBarHomeComponent: Component<TabBarHomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TabBarHomeBuildable: Buildable {
    func build(withListener listener: TabBarHomeListener) -> TabBarHomeRouting
}

final class TabBarHomeBuilder: Builder<TabBarHomeDependency>, TabBarHomeBuildable {

    override init(dependency: TabBarHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TabBarHomeListener) -> TabBarHomeRouting {
        let component = TabBarHomeComponent(dependency: dependency)
        let viewController = TabBarHomeViewController()
        let interactor = TabBarHomeInteractor(presenter: viewController)
        
        //자식 리블렛 셋팅
        interactor.listener = listener
        return TabBarHomeRouter(interactor: interactor, viewController: viewController)
    }
}
