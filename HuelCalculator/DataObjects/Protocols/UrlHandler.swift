//
//  UrlHandler.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol UrlHandler {
    func openURL(_ url: URL) -> Bool
    @available(iOS 10.0, *)
    func open(_ url: URL, options: [String : Any], completionHandler completion: ((Bool) -> Swift.Void)?)
}

extension UIApplication: UrlHandler {}
