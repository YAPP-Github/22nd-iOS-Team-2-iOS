//
//  EventBannerCell.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/10.
//

import UIKit
import SnapKit

final class EventBannerCell: UICollectionViewCell {
    
    enum SectionType: Hashable {
        case event
    }
    
    enum ItemType: Hashable {
        case event(imageUrl: String)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>?
    private var eventBannerUrls: [String] = ["test1", "test2", "test3"]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        return collectionView
    }()
    
    let pageCountContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let pageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1/22"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        configureUI()
        configureDatasource()
        setupCollectionView()
        makeSnapshot()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    private func configureUI() {
        self.makeRounded(with: 16)
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case .event(let item):
                let cell: EventBannerItemCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "EventBannerItemCell", for: indexPath) as? EventBannerItemCell
                return cell ?? UICollectionViewCell()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        registerCollectionViewCells()
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(EventBannerItemCell.self,
                                forCellWithReuseIdentifier: "EventBannerItemCell")
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        //append event section
        if !eventBannerUrls.isEmpty {
            snapshot.appendSections([.event])
            let eventUrls = eventBannerUrls.map { eventUrl in
                return ItemType.event(imageUrl: eventUrl)
            }
            snapshot.appendItems(eventUrls, toSection: .event)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let sectionLayout = EventHomeSectionLayout()
            return sectionLayout.eventLayout(isHeaderViewNeeded: false)
        }
    }
    
    private func setLayout() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageCountContainerView)
        collectionView.backgroundColor = .blue
        pageCountContainerView.addSubview(pageCountLabel)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageCountContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        pageCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
    }
}

extension EventBannerCell: UICollectionViewDelegate {
    
}
