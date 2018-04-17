//
//  DeviceInfo.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol DeviceInfo {
    var systemVersion: String { get }
    var modelName: String { get }
}

extension UIDevice: DeviceInfo {}
