//
//  EventHomeSectionLayout.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/10.
//

import UIKit

final class EventHomeSectionLayout {
    
    enum Size {
        enum Item {
            static let width: CGFloat = 171
            static let height: CGFloat = 235
        }
        
        enum Event {
            static let width: CGFloat = 358
            static let height: CGFloat = 184
        }
    }
    
    func section(at type: EventHomeViewController.SectionType) -> NSCollectionLayoutSection {
        switch type {
        case .event:
            return eventLayout()
        case .item:
            return itemLayout()
        }
    }
    
    private func eventLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .absolute(Size.Event.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func itemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(Size.Item.width),
                                               heightDimension: .absolute(Size.Item.height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}
