//
//  DetailViewController.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 10/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var gamePoster: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameViewers: UILabel!
    @IBOutlet weak var gameChannels: UILabel!
    @IBOutlet weak var gamePopularity: UILabel!
    @IBOutlet weak var gameDescTextView: UITextView!
    var twitchModel: TwitchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = twitchModel?.name
        self.gameName.text = twitchModel?.name
        self.gameViewers.text = String(format: "Current number of viewers: %@", (twitchModel?.viewers.stringValue)!)
        self.gameChannels.text = String(format: "Current number of channels: %@", (twitchModel?.numberChannels.stringValue)!)
        self.gamePopularity.text = String(format: "Popularity: %@", (twitchModel?.popularity.stringValue)!)
        APIController.getGameDescription(giantbombID: (twitchModel?.giantbombID.stringValue)!) { gameDesc in
            self.gameDescTextView.text = gameDesc
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.gamePoster.image = twitchModel?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
