//
//  KeychainValue.swift
//  Checklists
//
//  Created by John Paul Otim on 29.05.22.
//

import Combine
import CombineExt
import Foundation
import KeychainSwift

@propertyWrapper
class KeychainValue<T: Codable> {
    
    static var keychainWrapper: KeychainSwift {
        return KeychainSwift()
    }
    
    struct Wrapper: Codable {
        let value: T
    }
    
    private let subject: PassthroughSubject<T, Never> = PassthroughSubject()
    private let key: String
    private let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = Self.keychainWrapper.getData(key) else {
                return defaultValue
            }
            
            return (try? PropertyListDecoder().decode(Wrapper.self, from: data))?.value ?? defaultValue
        }
        
        set(newValue) {
            let wrapper = Wrapper(value: newValue)
            
            guard let encodedData = try? PropertyListEncoder().encode(wrapper) else { return }
            Self.keychainWrapper.set(encodedData, forKey: key)
            subject.send(newValue)
        }
    }
    
    lazy var publisher: AnyPublisher<T, Never> = {
        subject.prepend(wrappedValue)
            .share(replay: 1)
            .eraseToAnyPublisher()
    }()
    
}
