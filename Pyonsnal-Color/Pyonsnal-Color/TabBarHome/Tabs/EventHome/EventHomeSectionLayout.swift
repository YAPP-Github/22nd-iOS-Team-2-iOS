//
//  EventHomeSectionLayout.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/10.
//

import UIKit

final class EventHomeSectionLayout {
    
    enum Size {
        enum Event {
            static let width: CGFloat = 358
            static let height: CGFloat = 184
        }
        
        enum Item {
            static let width: CGFloat = 171
            static let height: CGFloat = 235
        }
        
        enum Header {
            static let height: CGFloat = 24
        }
        
        static let cellInterspacing: CGFloat = 16
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(Size.Event.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = createSupplementaryView()
        return section
    }

    private func itemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(Size.Item.height))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        group.interItemSpacing = .fixed(16)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        section.boundarySupplementaryItems = createSupplementaryView()
        return section
    }
    
    private func createSupplementaryView() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                           heightDimension: .absolute(Size.Header.height)),
                                                                        elementKind: "ItemHeaderTitleView", alignment: .top)
        sectionHeader.pinToVisibleBounds = true // 고정
        return [sectionHeader]
    }
}
