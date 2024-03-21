//
//  CustomToolbar.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 20.03.2024.
//

import UIKit

class CustomToolbar: UIView {

    //MARK: - UICompanents
    private let addButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = AppIcon.plus.image()
        button.configuration = configuration
        return button
    }()
    private let rateButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = AppIcon.heart.image()
        button.configuration = configuration
        return button
    }()
    private let downloadButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = AppIcon.download.image()
        button.configuration = configuration
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .white
        configuration.image = AppIcon.share.image()
        button.configuration = configuration
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addButton, rateButton, downloadButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupStackView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
