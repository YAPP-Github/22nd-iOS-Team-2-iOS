//
//  EventBannerItemCell.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/11.
//

import UIKit
import SnapKit

protocol EventBannerItemCellDelegate: AnyObject {
    func didTapBannerItemCell()
}

final class EventBannerItemCell: UICollectionViewCell {
    
    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TestBannerImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    weak var delegate: EventBannerItemCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureAction()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAction() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapBannerItemCell)
        )
        eventImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setLayout() {
        contentView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func didTapBannerItemCell() {
        delegate?.didTapBannerItemCell()
    }
}
