//
//  RootTabBarInteractor.swift
//  Pyonsnal-Color
//
//  Created by 김인호 on 2023/06/10.
//

import ModernRIBs

protocol RootTabBarRouting: ViewableRouting {
}

protocol RootTabBarPresentable: Presentable {
    var listener: RootTabBarPresentableListener? { get set }
}

protocol RootTabBarListener: AnyObject {
}

final class RootTabBarInteractor:
    PresentableInteractor<RootTabBarPresentable>,
    RootTabBarInteractable,
    RootTabBarPresentableListener {

    weak var router: RootTabBarRouting?
    weak var listener: RootTabBarListener?

    override init(presenter: RootTabBarPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
