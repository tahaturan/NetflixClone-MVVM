//
//  AppSearchButton.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 26.02.2024.
//

import UIKit

class AppSearchButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setImage(AppIcon.search.image(), for: .normal)
        backgroundColor = .tabbarBackround
        tintColor = .white
        layer.cornerRadius = AppSize.searchButton.size().height / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tintColor = .red.withAlphaComponent(0.6)
        backgroundColor = .tabbarBackround.withAlphaComponent(0.8)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        tintColor = .white
        backgroundColor = .tabbarBackround
    }
}
