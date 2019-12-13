//
//  UserDefaults+StronglyTyped.swift
//  UserDefaultsDemo
//
//  Created by Ben Scheirman on 12/6/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import Foundation

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

    func value<V>(for key: Key<V>) -> V? {
        return value(forKey: key.name) as? V
    }

    func removeValue<V>(for key: Key<V>) {
        removeObject(forKey: key.name)
    }
}
