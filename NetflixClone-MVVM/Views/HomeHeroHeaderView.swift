//
//  HomeHeroHeaderView.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 4.03.2024.
//

import UIKit

class HomeHeroHeaderView: UIView {
    //MARK: - UIComponents
  private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .header
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.viewBackround.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}
