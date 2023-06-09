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
            static let dividerMargin: CGFloat = 10
            static let dividerHeight: CGFloat = 10
            static let contentImageViewHeight: CGFloat = 100
            static let containerViewHeight: CGFloat = 70
            static let convinientImageViewMargin: CGFloat = 36
            static let convinientImageViewWidth: CGFloat = 36
        }
    }
    
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var contentImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.append.fill.rtl")
        return imageView
    }()
    
    lazy var dividerView: UIView = {
        var dividerView = UIView()
        dividerView.backgroundColor = .black
        return dividerView
    }()
    
    lazy var itemContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var convinientImageTagView: UIImageView = { // 편의점 tag
        var imageView = UIImageView()
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(contentImageView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(itemContainerView)
        
        contentImageView.addSubview(convinientImageTagView)
        
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
    }
}
