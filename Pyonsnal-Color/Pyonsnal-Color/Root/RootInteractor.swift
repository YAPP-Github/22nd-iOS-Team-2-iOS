//
//  RootInteractor.swift
//  Pyonsnal-Color
//
//  Created by 김진우 on 2023/05/29.
//

import ModernRIBs

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn() //loggedOut 리블렛을 떼고 loggedIn 리블렛을 붙임
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {
}

final class RootInteractor:
    PresentableInteractor<RootPresentable>,
    RootInteractable,
    RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didLogin() {
        router?.routeToLoggedIn() //자식 리블렛 떼는 역할을 RootRouter로 전달
    }
}
