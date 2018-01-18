//
//  TwitchModel.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

public class TwitchModel: NSObject {

    public var name : String? = ""
    public var image: UIImage? = UIImage()
    public var imageLink: String? = ""
    public var viewers: NSNumber? = 0
    public var numberChannels: NSNumber? = 0
    public var popularity: NSNumber? = 0
    public var giantbombID: NSNumber? = 0
    
    public init(data: NSDictionary) {
        name = data.value(forKeyPath: "game.name") as? String
        imageLink = data.value(forKeyPath: "game.box.large") as? String
        viewers = data.value(forKeyPath: "viewers") as? NSNumber
        numberChannels = data.value(forKeyPath: "channels") as? NSNumber
        popularity = data.value(forKeyPath: "game.popularity") as? NSNumber
        giantbombID = data.value(forKeyPath: "game.giantbomb_id") as? NSNumber
    }
}
