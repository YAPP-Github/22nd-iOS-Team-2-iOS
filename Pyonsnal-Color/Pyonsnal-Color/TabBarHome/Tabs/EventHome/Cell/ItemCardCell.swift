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
            
            static let itemImageContainerViewHeight: CGFloat = 171
            
            static let itemImageViewMargin: CGFloat = 25.5
            
            static let containerViewHeight: CGFloat = 64
            static let convinientImageViewMargin: CGFloat = 12
            static let convinientImageViewWidth: CGFloat = 36
            
            static let tagImageViewMargin: CGFloat = 12
            static let tagImageViewWidth: CGFloat = 38
            
            static let newTagLabelViewMargin: CGFloat = 12
            static let newTagLabelViewWidth: CGFloat = 29
            static let newTagLabelViewHeight: CGFloat = 20
            
            static let titleLabelLeading: CGFloat = 4
            static let titleLabelMargin: CGFloat = 12
            
            static let priceContainerViewTop: CGFloat = 4
            static let priceContainerViewHeight: CGFloat = 64
            static let priceContainerViewMargin: CGFloat = 12
            
            static let cornerRadius: CGFloat = 16
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    let itemImageContainerView: UIView = {
        let view = UIView()
        //TO DO : fix color
        view.backgroundColor = .white
        return view
    }()
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "TestItemImage")
        return imageView
    }()
    
    let dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    let itemContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let newTagLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        //TO DO : fix color
        label.textColor = UIColor(red: 236/255,
                                  green: 102/255,
                                  blue: 83/255,
                                  alpha: 1)
        return label
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
        label.text = "2,900" + "원" + "2,900" + "원"
        return label
    }()
    
    let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "2,000" + "원" + "2,000" + "원"
        return label
    }()
    
    let convinientTagImageView: UIImageView = { // 편의점 tag
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TestConvientTagImage")
        return imageView
    }()
    
    let eventTagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(named: "TesteventTagImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.makeRounded(with: Constants.Size.cornerRadius)
        //TO DO : fix color
        discountPriceLabel.attributedText = discountPriceLabel.text?.strikeThrough(with: UIColor.red)
    }
    
    private func setLayout() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(itemImageContainerView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(itemContainerView)
        
        itemImageContainerView.addSubview(itemImageView)
        itemImageContainerView.addSubview(convinientTagImageView)
        itemImageContainerView.addSubview(eventTagImageView)
        
        itemContainerView.addSubview(newTagLabel)
        itemContainerView.addSubview(titleLabel)
        itemContainerView.addSubview(priceContainerView)
        
        priceContainerView.addSubview(originalPriceLabel)
        priceContainerView.addSubview(discountPriceLabel)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itemImageContainerView.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.itemImageContainerViewHeight)
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(Constants.Size.dividerHeight)
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.Size.itemImageViewMargin)
            $0.trailing.bottom.equalToSuperview().inset(Constants.Size.itemImageViewMargin)
        }
        
        convinientTagImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Constants.Size.convinientImageViewMargin)
            $0.width.height.equalTo(Constants.Size.convinientImageViewWidth)
        }
        
        eventTagImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Constants.Size.tagImageViewMargin)
            $0.width.equalTo(Constants.Size.tagImageViewWidth)
        }
        
        newTagLabel.snp.contentHuggingHorizontalPriority = 251
        titleLabel.snp.contentHuggingHorizontalPriority = 250
        
        newTagLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(Constants.Size.newTagLabelViewMargin)
            $0.width.equalTo(40)
            $0.bottom.equalTo(priceContainerView.snp.top)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.Size.titleLabelMargin)
            $0.leading.equalTo(newTagLabel.snp.trailing).offset(Constants.Size.titleLabelLeading)
            $0.trailing.lessThanOrEqualTo(-Constants.Size.titleLabelMargin)
        }
        
        priceContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Size.priceContainerViewTop)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Size.priceContainerViewMargin)
        }
        
        originalPriceLabel.snp.contentHuggingHorizontalPriority = 251
        discountPriceLabel.snp.contentHuggingHorizontalPriority = 250
        
        originalPriceLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        discountPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(originalPriceLabel.snp.trailing)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        
        
    }
}
