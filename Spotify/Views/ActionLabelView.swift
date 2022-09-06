//
//  ActionLabelView.swift
//  Spotify
//
//  Created by Andy Hao on 2022/8/24.
//

import UIKit

struct ActionLabelViewModel {
    let text: String
    let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject {
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView {
    // MARK: - Properties
    
    weak var delegate: ActionLabelViewDelegate?
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    
    // MARK: - Helper functions
    
    func configureUI() {
        let stack = UIStackView(arrangedSubviews: [label, button])
        addSubview(stack)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.center(inView: self)
        stack.setDimensions(height: height , width: width)
    }
    
    func configure(with viewModel: ActionLabelViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
    
    
    // MARK: - Actions
    @objc func didTapButton() {
        print("Did Tap button!")
        delegate?.ActionLabelViewDidTapButton(self)
    }
}
