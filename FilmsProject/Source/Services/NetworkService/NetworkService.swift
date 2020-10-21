//
//  NetworkService.swift
//  FilmsProject
//
//  Created by iphonovv on 13.10.2020.
//

import Foundation
import Reachability
import Network
import Connectivity

protocol NetworkServiceType {
    var isReachableDidChanged: ((Bool) -> ())? { get set }
    var isReachable: Bool { get }
}

class NetworkServiceConnectivity: NetworkServiceType {
    
    var isReachableDidChanged: ((Bool) -> ())?
    var isReachable: Bool {
        return self.isReachableValue
    }
    
    var connectivity: Connectivity?
    
    var isReachableValue: Bool = true {
        didSet {
            self.isReachableDidChanged?(self.isReachableValue)
        }
    }
    
    init() {
        self.start()
    }
    
    private func start() {
        let connectivity: Connectivity = Connectivity()

        let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
            DispatchQueue.main.async {
                self?.updateConnectionStatus(connectivity.status)
            }
        }

        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged

        connectivity.isPollingEnabled = true
        connectivity.startNotifier()
        
        self.connectivity = connectivity
    }
    
    func updateConnectionStatus(_ status: ConnectivityStatus) {
        switch status {
        case .connected, .connectedViaCellular, .connectedViaWiFi:
            self.isReachableValue = true
        case .connectedViaWiFiWithoutInternet, .notConnected, .connectedViaCellularWithoutInternet, .determining:
            self.isReachableValue = false
        }
    }
}
