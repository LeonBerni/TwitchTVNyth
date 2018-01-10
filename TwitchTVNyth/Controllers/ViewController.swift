//
//  ViewController.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var twitchModelArray: [TwitchModel]?
    var pageLink: String = ""
    var twitchModelToDetail: TwitchModel?
    var loadingGames = false
    override func viewDidLoad() {
        super.viewDidLoad()
        twitchModelArray = Array()
        APIController.getTopGames(link: nil, completion: {JSONData,nextLink  in
            for item in JSONData {
                self.twitchModelArray?.append(TwitchModel(data: item ))
            }
            self.pageLink = nextLink
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        collectionView.setContentOffset(CGPoint.zero, animated: true)
        APIController.getTopGames(link: nil, completion: {JSONData,nextLink  in
            self.twitchModelArray = Array()
            for item in JSONData {
                self.twitchModelArray?.append(TwitchModel(data: item ))
            }
            self.pageLink = nextLink
            self.collectionView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.twitchModel = twitchModelToDetail
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView.cellForItem(at: indexPath) as! TwitchCollectionViewCell
        twitchModelToDetail = cell.twitchModel
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (twitchModelArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "twitchCell", for: indexPath) as! TwitchCollectionViewCell
        let twitchModel = twitchModelArray![indexPath.row]
        cell.twitchModel = twitchModel
        cell.gameNameLabel.text = twitchModel.name
        APIController.getGamePoster(url: cell.twitchModel?.imageLink, cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == (twitchModelArray?.count)!-7 && !loadingGames) {
            loadingGames = true
            APIController.getTopGames(link: pageLink, completion: {JSONData,nextLink  in
                for item in JSONData {
                    self.twitchModelArray?.append(TwitchModel(data: item ))
                }
                self.pageLink = nextLink
                self.collectionView.reloadData()
                self.loadingGames = false
            })
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
    }
    
}
