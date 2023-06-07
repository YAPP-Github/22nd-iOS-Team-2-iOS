//
//  TabBarHomeRouter.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import ModernRIBs

protocol TabBarHomeInteractable: Interactable,
                                 AppHomeListener,
                                 EventHomeListener,
                                 ProfileHomeListener{
    var router: TabBarHomeRouting? { get set }
    var listener: TabBarHomeListener? { get set }
}

protocol TabBarHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class TabBarHomeRouter: ViewableRouter<TabBarHomeInteractable, TabBarHomeViewControllable>, TabBarHomeRouting {

    private let appHome: AppHomeBuildable
    private let eventHome: EventHomeBuildable
    private let profileHome: ProfileHomeBuildable
    
    private var appHomeRouting: ViewableRouting?
    private var eventHomeRouting: ViewableRouting?
    private var profileHomeRouting: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: TabBarHomeInteractable,
                  viewController: TabBarHomeViewControllable,
                  appHome: AppHomeBuildable,
                  eventHome: EventHomeBuildable,
                  profileHome: ProfileHomeBuildable) {
        self.appHome = appHome
        self.eventHome = eventHome
        self.profileHome = profileHome
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        let appHomeRouting = appHome.build(withListener: interactor)
        let eventHomeRouting = eventHome.build(withListener: interactor)
        let profileHomeRouting = profileHome.build(withListener: interactor)
        //ribs 프레임워크에 있는 메소드 attachChild
        attachChild(appHomeRouting)
        attachChild(eventHomeRouting)
        attachChild(profileHomeRouting)
        
        let viewControllers = [
            NavigationControllerable(root: appHomeRouting.viewControllable),
            NavigationControllerable(root: eventHomeRouting.viewControllable),
            profileHomeRouting.viewControllable //viewControllable - UIViewController를 감싼 인터페이스
        ]
        
        viewController.setViewControllers(viewControllers)
    }
}
