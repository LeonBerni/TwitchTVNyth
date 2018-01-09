//
//  APIController.swift
//  TwitchTVNyth
//
//  Created by Leon Berni on 09/01/18.
//  Copyright © 2018 Leon Berni. All rights reserved.
//

import Foundation
import Alamofire
//import AlamofireImage

class APIController {
    
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
    
    class func getTopGames(completion: (_ result: NSDictionary) -> Void) {
        
    }
}
