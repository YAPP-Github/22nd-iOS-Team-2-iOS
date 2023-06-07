//
//  TabBarHomeRouter.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs

protocol TabBarHomeInteractable: Interactable {
    var router: TabBarHomeRouting? { get set }
    var listener: TabBarHomeListener? { get set }
}

protocol TabBarHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TabBarHomeRouter: ViewableRouter<TabBarHomeInteractable, TabBarHomeViewControllable>, TabBarHomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TabBarHomeInteractable, viewController: TabBarHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
