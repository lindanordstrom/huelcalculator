//
//  DataStore.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-12.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation

protocol DataStore {
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
}

extension UserDefaults: DataStore {}
