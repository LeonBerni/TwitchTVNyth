//
//  APIController.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class APIController {
    
    class func getGamePoster(url: String?, cell: TwitchCollectionViewCell) -> () {
        if (url != nil){
            Alamofire.request(url!).responseImage { response in
                if let image = response.result.value {
                    cell.gameLogoImageView.image = image
                    cell.twitchModel?.image = image
                }
            }
        }
    }
    
    class func getGameDescription(giantbombID: String, completion: @escaping (_ description: String) -> Void){
        let url = String(format: "http://www.giantbomb.com/api/game/%@/?api_key=67813afdc1110df5103b7ada30e2fc899627971c&format=json&field_list=description", giantbombID)
        Alamofire.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        let gameDesc = JSON.value(forKeyPath: "results.description") as! String
                        
                        let str = gameDesc.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        completion(str)
                    }
                default:
                    print("Whoops")
                }
            }
        }
    }
    
    class func getAcessToken(completion: @escaping (_ result: Bool) -> Void) {
        
        let url = "https://api.twitch.tv/kraken/oauth2/token"
        
        let parameters: [String : Any?] = [
            "client_id": "ja4j5rpnh4itkq9vdq8twxol1cuuyx",
            "client_secret": "b5b0lrpogam11m8umfmzxbs00nso8d",
            "grant_type": "client_credentials"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        let accessToken = JSON.value(forKey: "access_token") as! String
                        UserDefaults.standard.set(accessToken, forKey: "access_token")
                        print(accessToken)
                        completion(true)
                    }
                default:
                    print("Whoops")
                }
            }
        }
    }
    
    class func getTopGames(link: String?, completion: @escaping (_ result: [NSDictionary], _ nextLink: String) -> Void) {
        var url = ""
        if (link == nil){
            url = "https://api.twitch.tv/kraken/games/top?limit=30"
        } else {
            url = link!
        }
        
        
        let header: [String : String] = [ "Client-ID": "ja4j5rpnh4itkq9vdq8twxol1cuuyx" ]
        
        Alamofire.request(url, method: .get, parameters: ["":""], encoding: JSONEncoding.default, headers: header).responseJSON { response in
            //to get status code
            if let status = response.response?.statusCode {
                print(response)
                switch(status){
                case 200:
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        guard let linksFromJson = JSON.value(forKey: "_links") as? [String: String]
                            else{
                                return;
                        }
                        
                        print(linksFromJson["next"]!)
                        completion(JSON.value(forKey: "top") as! [NSDictionary], linksFromJson["next"]! as! String)
                    }
                case 400:
                    print("Done requesting")
                default:
                    print("Something went wrong")
                }
            }
        }
    }
}
