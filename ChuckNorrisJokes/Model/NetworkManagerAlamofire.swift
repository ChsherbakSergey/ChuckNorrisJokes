//
//  NetworkManagerAlomofire.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkManagerAlamofireDelegate: class {
    func didGetResult(with result: [String])
}

final class NetworkManagerAlamofire {
    
    weak var delegate: NetworkManagerAlamofireDelegate?
    
    let baseUrl = "https://api.icndb.com/jokes/random/"
    
    func requestJokes(withNumber numberOfJokes: Int) {
        
        Alamofire.request("\(baseUrl)\(numberOfJokes)", method: .get).responseJSON { [weak self] (response) in
            
            if response.result.isSuccess {
                
                var jokesArray: [String] = []
                
                let responseJSON: JSON = JSON(response.result.value as Any)
                
                for (i, _) in responseJSON["value"].enumerated() {
                    let query = responseJSON["value"]
                    let joke = query[i]["joke"].stringValue.replacingOccurrences(of: "&quot;", with: "\"")
                    jokesArray.append(joke)
                }
                
                self?.delegate?.didGetResult(with: jokesArray)
            }
            
        }
        
    }
    
}
