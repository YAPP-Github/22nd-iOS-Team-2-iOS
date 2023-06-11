//
//  EventHomeViewController.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/08.
//

import UIKit
import ModernRIBs
import SnapKit

struct ItemCard: Hashable {
    var uuid = UUID()
    var imageUrl: UIImage
    var itemName: String
    var convinientStoreTagImage: UIImage
    var eventTagImage: UIImage
}

protocol EventHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class EventHomeViewController: UIViewController,
                                     EventHomePresentable,
                                     EventHomeViewControllable {
    
    enum SectionType: Hashable {
        case event
        case item
    }
    
    enum ItemType: Hashable {
        case event(data: String)
        case item(data: ItemCard)
    }

    weak var listener: EventHomePresentableListener?
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>?
    private var dummyImage = UIImage(systemName: "note")!
    private var itemCards: [ItemCard] = []
    private var eventUrls: [String] = []
    
    lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDummyData()
        configureUI()
        configureDatasource()
        configureHeaderView()
        makeSnapshot()
    }
    
    private func setupDummyData() {
        itemCards = [
            ItemCard(imageUrl: dummyImage,
                     itemName: "산리오)햄치즈에그모닝머핀ddd",
                     convinientStoreTagImage: dummyImage,
                     eventTagImage: dummyImage),
            ItemCard(imageUrl: dummyImage,
                     itemName: "나가사끼 짬뽕",
                     convinientStoreTagImage: dummyImage,
                     eventTagImage: dummyImage),
            ItemCard(imageUrl: dummyImage,
                     itemName: "나가사끼 짬뽕",
                     convinientStoreTagImage: dummyImage,
                     eventTagImage: dummyImage),
        ]
        eventUrls = ["test"]
    }
    
    private func configureUI() {
        //TO DO : fix color
        collectionView.backgroundColor = .gray
        setNavigationView()
        setupCollectionView()
        setupViews()
        
    }
    
    private func setNavigationView() {
        title = "이벤트"
        tabBarItem = UITabBarItem(title: "이벤트",
                                  image: UIImage(systemName: "square.and.arrow.up"),
                                  selectedImage: UIImage(systemName: "square.and.arrow.up.fill"))
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        registerCollectionViewCells()
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(ItemHeaderTitleView.self,
                                forSupplementaryViewOfKind: "ItemHeaderTitleView",
                                withReuseIdentifier: "ItemHeaderTitleView")
        collectionView.register(EventBannerCell.self,
                                forCellWithReuseIdentifier: "EventBannerCell")
        collectionView.register(ItemCardCell.self,
                                forCellWithReuseIdentifier: "ItemCardCell")
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            switch item {
            case .item(let item):
                let cell: ItemCardCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCardCell",
                                                                            for: indexPath) as? ItemCardCell
                return cell ?? UICollectionViewCell()
            case .event(let item):
                let cell: EventBannerCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "EventBannerCell", for: indexPath) as? EventBannerCell
                return cell ?? UICollectionViewCell()
            }
        }
    }
    
    private func configureHeaderView() {
        dataSource?.supplementaryViewProvider = makeSupplementaryView
    }
    
    private func makeSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
            case "ItemHeaderTitleView":
            let itemHeaderTitleView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: kind,
                                                                                      for: indexPath) as? ItemHeaderTitleView
            itemHeaderTitleView?.update()
            return itemHeaderTitleView
        default:
            return nil
        }
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        //append event section
        if !eventUrls.isEmpty {
            snapshot.appendSections([.event])
            let eventUrls = eventUrls.map { eventUrl in
                return ItemType.event(data: eventUrl)
            }
            snapshot.appendItems(eventUrls, toSection: .event)
        }
        
        //append item section
        if !itemCards.isEmpty {
            snapshot.appendSections([.item])
            let itemCards = itemCards.map { itemCard in
                return ItemType.item(data: itemCard)
            }
            snapshot.appendItems(itemCards, toSection: .item)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let sectionIdentifier = self?.dataSource?.snapshot().sectionIdentifiers[sectionIndex] else {
                return nil
            }
            
            let layout = EventHomeSectionLayout()
            return layout.section(at: sectionIdentifier)
        }
    }
    
    

}

extension EventHomeViewController: UICollectionViewDelegate {
    
}
