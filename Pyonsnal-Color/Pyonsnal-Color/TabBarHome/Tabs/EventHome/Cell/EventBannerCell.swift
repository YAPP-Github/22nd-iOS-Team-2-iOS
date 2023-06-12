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
    private var timer: Timer?
    private var timerSecond = 5.0
    private var currentIndex = 0 {
        didSet {
            updatePageCountLabel(with: currentIndex)
        }
    }
    private var startContentOffsetX: CGFloat = 0
    private var eventBannerUrls: [String] = ["test1", "test2", "test3", "test4", "test5"]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let pageCountContainerView: UIView = {
        let view = UIView()
        // TO DO : fix color
        view.backgroundColor = UIColor.black
        view.layer.opacity = 0.5
        return view
    }()
    
    private let pageCountLabel: UILabel = {
        let label = UILabel()
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
    
    deinit {
        self.stopTimer()
    }
    
    //TO DO : item 연결
    func update(_ eventBannerUrls: [String]) {
        if !eventBannerUrls.isEmpty {
            setTimer()
        }
    }
    
    // MARK: - Private Method
    private func configureUI() {
        self.makeRounded(with: 16)
        updatePageCountLabel(with: currentIndex)
        pageCountContainerView.makeRounded(with: 12)
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

//MARK: - Timer
extension EventBannerCell {
    
    private func setTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timerSecond,
                                     repeats: true) { [weak self] _ in
            self?.setAutoScroll()
        }
    }
    
    private func setAutoScroll() {
        var updatedIndex = self.currentIndex + 1
        var indexPath: IndexPath
        var animated: Bool = true

        if updatedIndex < self.eventBannerUrls.count {
            indexPath = IndexPath(item: updatedIndex, section: 0)
        } else {
            indexPath = IndexPath(item: 0, section: 0)
            updatedIndex = 0
            animated = false
        }

        self.currentIndex = updatedIndex
        self.collectionView.scrollToItem(at: indexPath,
                                         at: .right, animated: animated)
    }

    private func updatePageCountLabel(with index: Int) {
        guard !eventBannerUrls.isEmpty,
        index <= eventBannerUrls.count else { return }
        let updatedIndex = currentIndex + 1
        setPageCountLabelText(with: updatedIndex)
    }
    
    private func setPageCountLabelText(with updatedIndex: Int) {
        //TO DO :fix color, font
        let attributedText = NSMutableAttributedString()
        attributedText.appendAttributes(string: "\(updatedIndex)",
                                        font: UIFont.systemFont(ofSize: 12),
                                        color: UIColor(red: 255,
                                                       green: 255,
                                                       blue: 255,
                                                       alpha: 1))
        attributedText.appendAttributes(string: "/\(eventBannerUrls.count)",
                                        font: UIFont.systemFont(ofSize: 12),
                                        color: UIColor(red: 224,
                                                       green: 224,
                                                       blue: 224,
                                                       alpha: 1))
        pageCountLabel.attributedText = attributedText
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

//MARK: - UICollectionViewDelegate
extension EventBannerCell: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        setTimer()
    }
}

extension EventBannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
