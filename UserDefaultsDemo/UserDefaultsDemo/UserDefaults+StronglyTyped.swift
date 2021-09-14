//
//  UserDefaults+StronglyTyped.swift
//  UserDefaultsDemo
//
//  Created by Ben Scheirman on 12/6/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import Foundation

protocol UserDefaultsSerializable: Codable { }

extension UserDefaults {
    struct Key<Value> {
        fileprivate var name: String

        init(name: String) {
            self.name = name
        }
    }

    func set<V>(_ value: V, for key: Key<V>) {
        set(value, forKey: key.name)
    }
    
    func set<S: RawRepresentable>(_ value: S, for key: Key<S>) where S.RawValue == String {
        set(value.rawValue, forKey: key.name)
    }

    func set<C: UserDefaultsSerializable>(_ value: C, for key: Key<C>) {
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(value)
            setValue(data, forKey: key.name)
        } catch {
            print(error)
        }
    }
    
    func value<V>(for key: Key<V>) -> V? {
        return value(forKey: key.name) as? V
    }
    
    func value<S: RawRepresentable>(for key: Key<S>) -> S? where S.RawValue == String {
        if let rawValue = value(forKey: key.name) as? String {
            return S(rawValue: rawValue)
        }
        
        return nil
    }
    
    func value<C: UserDefaultsSerializable>(for key: Key<C>) -> C? {
        do {
            let jsonDecoder = JSONDecoder()
            if let data = value(forKey: key.name) as? Data {
                return try jsonDecoder.decode(C.self, from: data)
            }
            return nil
        } catch {
            print("Unable to decode value for key \(key.name) - \(error)")
            return nil
        }
    }

    func removeValue<V>(for key: Key<V>) {
        removeObject(forKey: key.name)
    }
}
