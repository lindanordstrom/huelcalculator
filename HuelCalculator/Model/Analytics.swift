//
//  Analytics.swift
//  HuelCalculator
//
//  Created by Linda Nordström on 2018-09-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import Foundation
import Crashlytics

class Analytics {
    static func log(withName name: String?, contentType: String?, contentId: String?, customAttributes: [String: Any]?) {
        Answers.logContentView(withName: name, contentType: contentType, contentId: contentId, customAttributes: customAttributes)
    }
}
