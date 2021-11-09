//
//  ContentViewModel.swift
//  LanScannerExample
//
//  Created by Matheus Gois on 23/10/21.
//

import SwiftUI
import LanScanner

class ContentViewModel: ObservableObject {

    // Properties

    @Published var connectedDevices = [LanDevice]()
    @Published var progress: CGFloat = .zero
    @Published var title: String = "Play to start"
    @Published var showAlert = false
    @Published var isRunning = false

    private lazy var scanner = LanScanner(delegate: self)

    // Methos

    func toggle() {
        if isRunning {
            scanner.stop()
        } else {
            connectedDevices.removeAll()
            scanner.start()
        }
        isRunning.toggle()
    }
}

extension ContentViewModel: LanScannerDelegate {
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        self.progress = progress
        self.title = address
    }

    func lanScanDidFindNewDevice(_ device: LanDevice) {
        connectedDevices.append(device)
    }

    func lanScanDidFinishScanning() {
        showAlert = true
    }
}

extension LanDevice: Identifiable {
    public var id: UUID { .init() }
}
