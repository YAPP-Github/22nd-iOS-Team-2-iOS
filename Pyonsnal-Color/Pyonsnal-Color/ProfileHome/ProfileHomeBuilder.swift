//
//  ProfileHomeBuilder.swift
//  Pyonsnal-Color
//
//  Created by 김인호 on 2023/06/10.
//

import ModernRIBs

protocol ProfileHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ProfileHomeComponent: Component<ProfileHomeDependency>,
                                  AccountSettingDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ProfileHomeBuildable: Buildable {
    func build(withListener listener: ProfileHomeListener) -> ProfileHomeRouting
}

final class ProfileHomeBuilder: Builder<ProfileHomeDependency>,
                                ProfileHomeBuildable {

    override init(dependency: ProfileHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ProfileHomeListener) -> ProfileHomeRouting {
        let component = ProfileHomeComponent(dependency: dependency)
        let viewController = ProfileHomeViewController()
        let interactor = ProfileHomeInteractor(presenter: viewController)
        interactor.listener = listener
        let accountSettingBuilder = AccountSettingBuilder(dependency: component)
        return ProfileHomeRouter(interactor: interactor,
                                 viewController: viewController,
                                 accountSettingBuilder: accountSettingBuilder)
    }
}
