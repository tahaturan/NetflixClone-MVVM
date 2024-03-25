//
//  ReachabilityManager.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 25.03.2024.
//

import Foundation
import Reachability

enum ReachabilityStatus {
    case disconnected
    case connectedViaWifi
    case connectedViaCellular
}

protocol ReachabilityManagerDelegate: AnyObject {
    func networkStatusDidChange(to status: ReachabilityStatus)
}

final class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    private var reachability: Reachability?
    weak var delegate: ReachabilityManagerDelegate?
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        reachability = try? Reachability()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    @objc private func reachabilityChanged(_ note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        
        var status: ReachabilityStatus = .disconnected
        
        switch reachability.connection {
        case .unavailable:
            status = .disconnected
        case .wifi:
            status = .connectedViaWifi
        case .cellular:
            status = .connectedViaCellular
        }
        DispatchQueue.main.async {
            self.delegate?.networkStatusDidChange(to: status)
        }
        
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
