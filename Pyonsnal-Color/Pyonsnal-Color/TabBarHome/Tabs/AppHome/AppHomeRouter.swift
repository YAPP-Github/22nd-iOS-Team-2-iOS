//
//  AppHomeRouter.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs

protocol AppHomeInteractable: Interactable {
    var router: AppHomeRouting? { get set }
    var listener: AppHomeListener? { get set }
}

protocol AppHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AppHomeRouter: ViewableRouter<AppHomeInteractable, AppHomeViewControllable>, AppHomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AppHomeInteractable, viewController: AppHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
