//
//  UrlManager.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class UrlManager {
    private let urlHandler: UrlHandler
    static var shared = UrlManager()

    init(urlHandler: UrlHandler = UIApplication.shared) {
        self.urlHandler = urlHandler
    }

    func open(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        if #available(iOS 10.0, *) {
            urlHandler.open(url, options: [:], completionHandler: nil)
        } else {
            _ = urlHandler.openURL(url)
        }
    }
}

