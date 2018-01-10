//
//  TwitchModel.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

class TwitchModel: NSObject {

    var name : String? = ""
    var image: UIImage? = UIImage()
    var imageLink: String? = ""
    var viewers: NSNumber? = 0
    var numberChannels: NSNumber? = 0
    var popularity: NSNumber? = 0
    var giantbombID: NSNumber? = 0
    
    init(data: NSDictionary) {
        name = data.value(forKeyPath: "game.name") as? String
        imageLink = data.value(forKeyPath: "game.box.large") as? String
        viewers = data.value(forKeyPath: "viewers") as? NSNumber
        numberChannels = data.value(forKeyPath: "channels") as? NSNumber
        popularity = data.value(forKeyPath: "game.popularity") as? NSNumber
        giantbombID = data.value(forKeyPath: "game.giantbomb_id") as? NSNumber
    }
}
