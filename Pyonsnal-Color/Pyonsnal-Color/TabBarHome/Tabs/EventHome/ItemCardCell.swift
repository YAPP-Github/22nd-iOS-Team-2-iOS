//
//  ItemCardCell.swift
//  Pyonsnal-Color
//
//  Created by 조소정 on 2023/06/09.
//

import UIKit
import SnapKit

final class ItemCardCell: UICollectionViewCell {
    
    enum Constants {
        enum Size {
            static let dividerMargin: CGFloat = 12
            static let dividerHeight: CGFloat = 1
            
            static let contentImageViewHeight: CGFloat = 100
            
            static let containerViewHeight: CGFloat = 64
            static let convinientImageViewMargin: CGFloat = 12
            static let convinientImageViewWidth: CGFloat = 36
            
            static let tagImageViewMargin: CGFloat = 12
            static let tagImageViewWidth: CGFloat = 38
            
            static let newTagImageViewMargin: CGFloat = 12
            static let newTagImageViewWidth: CGFloat = 29
            static let newTagImageViewHeight: CGFloat = 20
            
            static let titleLabelLeading: CGFloat = 4
            static let titleLabelMargin: CGFloat = 12
            
            static let priceContainerViewTop: CGFloat = 4
            static let priceContainerViewMargin: CGFloat = 12
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(systemName: "doc.append.fill.rtl")
        return imageView
    }()
    
    let dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    let itemContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let newTagView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.append.fill.rtl")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "산리오)햄치즈에그모닝머핀ddd"
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let priceContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "2,900" + "원"
        return label
    }()
    
    let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "2,000" + "원"
        return label
    }()
    
    let convinientImageTagView: UIImageView = { // 편의점 tag
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.append.fill.rtl")
        return imageView
    }()
    
    let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(systemName: "doc.append.fill.rtl")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .gray
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(itemContainerView)
        
        contentImageView.addSubview(convinientImageTagView)
        contentImageView.addSubview(tagImageView)
        
        itemContainerView.addSubview(newTagView)
        itemContainerView.addSubview(titleLabel)
        itemContainerView.addSubview(priceContainerView)
        
        priceContainerView.addSubview(originalPriceLabel)
        priceContainerView.addSubview(discountPriceLabel)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentImageView.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.contentImageViewHeight)
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(Constants.Size.dividerMargin)
            $0.trailing.equalTo(Constants.Size.dividerMargin)
            $0.height.equalTo(Constants.Size.dividerHeight)
        }
        
        itemContainerView.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.containerViewHeight)
        }
        
        convinientImageTagView.snp.makeConstraints {
            $0.leading.top.equalTo(Constants.Size.convinientImageViewMargin)
            $0.width.height.equalTo(Constants.Size.convinientImageViewWidth)
        }
        
        tagImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Constants.Size.tagImageViewMargin)
            $0.width.equalTo(Constants.Size.tagImageViewWidth)
        }
        
        newTagView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(Constants.Size.newTagImageViewMargin)
            $0.width.equalTo(Constants.Size.newTagImageViewWidth)
            $0.height.equalTo(Constants.Size.newTagImageViewHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.Size.titleLabelMargin)
            $0.leading.equalTo(newTagView.snp.trailing).offset(Constants.Size.titleLabelLeading)
            $0.trailing.lessThanOrEqualTo(-Constants.Size.titleLabelMargin)
        }
        
        priceContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Size.priceContainerViewTop)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Size.priceContainerViewMargin)
        }
        
        originalPriceLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        discountPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(originalPriceLabel.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        
        
    }
}
