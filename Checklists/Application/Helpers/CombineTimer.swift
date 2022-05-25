//
//  CombineTimer.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import Foundation
import Combine

/// Simple Timer wrapped
final class CombineTimer {
    
        // MARK: - Variables
    
    private let intervalSubject: CurrentValueSubject<TimeInterval, Never>
    private var isRunning = true
    
        // MARK: - Computed Properties
    
    var interval: TimeInterval {
        get {
            intervalSubject.value
        }
        set {
            intervalSubject.send(newValue)
        }
    }
    
    var publisher: AnyPublisher<Date, Never> {
        intervalSubject
            .map {
                Timer.TimerPublisher(interval: $0, runLoop: .main, mode: .default).autoconnect()
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .filter(self.isRunning)
            .eraseToAnyPublisher()
    }
    
    init(interval: TimeInterval = 1.0) {
        intervalSubject = CurrentValueSubject<TimeInterval, Never>(interval)
    }
    
}

    // MARK: - Private

extension CombineTimer {
    
    private func isRunning(date: Date) -> Bool {
        return isRunning
    }
    
}

extension CombineTimer {
    
    func pause() {
        isRunning = false
    }
    
    func start() {
        isRunning = true
    }
    
}
