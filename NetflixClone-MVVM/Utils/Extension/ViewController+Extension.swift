//
//  ViewController+Extension.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 21.03.2024.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            completion?()
        }))
        self.present(alertController, animated: true)
    }
}
