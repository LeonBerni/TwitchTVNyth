//
//  ViewController.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIController.getAcessToken(completion:{ response in
            if (response){
                APIController.getTopGames(completion: {JSONData in
                    
                })
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    
}

