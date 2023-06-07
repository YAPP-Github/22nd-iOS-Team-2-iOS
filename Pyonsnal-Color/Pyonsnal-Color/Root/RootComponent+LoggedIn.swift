//
//  RootComponent+LoggedIn.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import Foundation

extension RootComponent: LoggedInDependency {
    var LoggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
    
    
}
