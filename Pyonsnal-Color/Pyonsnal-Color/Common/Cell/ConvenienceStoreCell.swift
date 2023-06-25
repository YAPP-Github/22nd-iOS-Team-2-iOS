//
//  ConvenienceStoreCell.swift
//  Pyonsnal-Color
//
//  Created by 김인호 on 2023/06/21.
//

import UIKit

final class ConvenienceStoreCell: UICollectionViewCell {
    enum Constant {
        enum Size {
            static let padding: UIEdgeInsets = .init(top: 11, left: 11, bottom: 11, right: 11)
            static let selectedViewHeight: CGFloat = 2
            static let font: UIFont = .body3m
        }
        
        enum Color {
            static let selectedColor: UIColor = .black
            static let deselectedColor: UIColor = .init(
                red: 0.702,
                green: 0.702,
                blue: 0.714,
                alpha: 1
            )
        }
    }
    
    enum Action {
        case selection(Bool)
    }
    
    override var isSelected: Bool {
        didSet {
            update(.selection(isSelected))
        }
    }
    
    private let viewHolder: ViewHolder = .init()
    
    final class ViewHolder: ViewHolderable {
        
        private let containerStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.layoutMargins = UIEdgeInsets(
                top: Constant.Size.padding.top,
                left: Constant.Size.padding.left,
                bottom: Constant.Size.padding.right,
                right: Constant.Size.padding.bottom
            )
            stackView.isLayoutMarginsRelativeArrangement = true
            return stackView
        }()

        let storeTitleLabel: UILabel = {
            let label = UILabel()
            label.font = Constant.Size.font
            label.textAlignment = .center
            label.textColor = Constant.Color.deselectedColor
            return label
        }()
        
        let indicatorView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
        
        func place(in view: UIView) {
            view.addSubview(containerStackView)
            view.addSubview(indicatorView)
            
            containerStackView.addArrangedSubview(storeTitleLabel)
        }
        
        func configureConstraints(for view: UIView) {
            containerStackView.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
            }
            
            indicatorView.snp.makeConstraints { make in
                make.top.equalTo(containerStackView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(Constant.Size.selectedViewHeight)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        viewHolder.place(in: contentView)
        viewHolder.configureConstraints(for: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(_ action: Action) {
        switch action {
        case let .selection(isSelected):
            toggleSelectedColor(isSelected: isSelected)
        }
    }

    private func toggleSelectedColor(isSelected: Bool) {
        if isSelected {
            viewHolder.storeTitleLabel.textColor = Constant.Color.selectedColor
            viewHolder.indicatorView.backgroundColor = Constant.Color.selectedColor
        } else {
            viewHolder.storeTitleLabel.textColor = Constant.Color.deselectedColor
            viewHolder.indicatorView.backgroundColor = .clear
        }
    }
    
    func configureCell(title: String) {
        viewHolder.storeTitleLabel.text = title
    }
}
