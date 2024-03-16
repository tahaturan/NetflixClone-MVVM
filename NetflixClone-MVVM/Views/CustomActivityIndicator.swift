//
//  CustomActivityIndicator.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 16.03.2024.
//

import UIKit

class CustomActivityIndicator: UIView {
    //MARK: - UIComponents
    private var activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.tintColor = .red
        indicator.startAnimating()
        return indicator
    }()
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    private func setupView() {
        backgroundColor = .clear
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func show(on view: UIViewController) {
        self.frame = view.view.bounds
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}
