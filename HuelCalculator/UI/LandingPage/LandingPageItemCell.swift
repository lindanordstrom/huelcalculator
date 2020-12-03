//
//  LandingPageItemCell.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class LandingPageItemCell: UICollectionViewCell {
    // swiftlint:disable private_outlet
    @IBOutlet weak var title: UILabel! {
        didSet {
            let fontSize = UIScreen.main.bounds.size.width <= 320 ? 12 : 15
            title.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        }
    }
    @IBOutlet weak var image: UIImageView!
}
