//
//  TwitchTVDetailViewController.swift
//  Pods
//
//  Created by Leon Berni on 17/01/18.
//

import UIKit


public protocol TwitchTVDetailViewControllerDataSource {
    func getDescription(vc: TwitchTVDetailViewController)
}
public class TwitchTVDetailViewController: UIViewController {
    
    @IBOutlet var gamePoster: UIImageView!
    @IBOutlet var gameName: UILabel!
    @IBOutlet var gameViewers: UILabel!
    @IBOutlet var gameChannels: UILabel!
    @IBOutlet var gamePopularity: UILabel!
    @IBOutlet var gameDescTextView: UITextView!
    public var twitchModel: TwitchModel?
    public var dataSource: TwitchTVDetailViewControllerDataSource?
    
    public class func initFromNIB() -> TwitchTVDetailViewController {
        let vc = TwitchTVDetailViewController(nibName: "TwitchTVDetailViewController", bundle: Bundle(for: TwitchTVDetailViewController.self))
        return vc
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = twitchModel?.name
        self.gameName.text = twitchModel?.name
        self.gameViewers.text = String(format: "Current number of viewers: %@", (twitchModel?.viewers?.stringValue)!)
        self.gameChannels.text = String(format: "Current number of channels: %@", (twitchModel?.numberChannels?.stringValue)!)
        self.gamePopularity.text = String(format: "Popularity: %@", (twitchModel?.popularity?.stringValue)!)
        dataSource?.getDescription(vc: self)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        self.gamePoster.image = twitchModel?.image
    }
    
    public func attributeGameDesc(string: String) {
        gameDescTextView.text = string
    }
    
}

