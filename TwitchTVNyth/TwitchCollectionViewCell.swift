//
//  TwitchCollectionViewCell.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

class TwitchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    var twitchModel: TwitchModel?
    
    override func prepareForReuse() {
        self.gameLogoImageView.image = UIImage()
        gameNameLabel.text = ""
    }
}
