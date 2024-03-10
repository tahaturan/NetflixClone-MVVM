//
//  LottieActivityIndicator.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 10.03.2024.
//

import UIKit
import Lottie
import SnapKit

final class LottieActivityIndicator: UIView {
    static let shared = LottieActivityIndicator()
    private let animationView = LottieAnimationView()
    private var isAnimating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("loadingLottie")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func show(in view: UIView) {
        if isAnimating { return }
        
        isAnimating = true
        frame = view.bounds
        view.addSubview(self)
        
        animationView.play()
    }
    func hide() {
        isAnimating = false
        animationView.stop()
        removeFromSuperview()
    }
}
