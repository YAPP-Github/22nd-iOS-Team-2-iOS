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
    }
    
    private func configureUI() {
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
        collectionView.backgroundColor = .blue
        collectionView.register(ItemCardCell.self,
                                forCellWithReuseIdentifier: "ItemCardCell")
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
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
                return UICollectionViewCell()
            }
        }
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        let section = SectionType.item
        
        snapshot.appendSections([section])
        let items = itemCards.map { itemCard in
            return ItemType.item(data: itemCard)
        }
        snapshot.appendItems(items, toSection: section)
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
