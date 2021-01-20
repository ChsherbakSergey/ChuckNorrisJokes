//
//  NetworkManager.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/19/21.
//

import Foundation

protocol NetworkManagerDelegate: class {
    func didFailWithError(error: Error)
    func didUpdateJokesAgain(_ networkManager: NetworkManager, jokes: [String])
}

struct NetworkManager {
    
    let baseUrl = "https://api.icndb.com/jokes/random/"
    
    weak var delegate: NetworkManagerDelegate?
    
    func fetchJokes(withQuantity quantity: Int) {
        let urlString = "\(baseUrl)\(quantity)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        // Create url
        guard let url = URL(string: url) else { return }
        //Create session
        let session = URLSession(configuration: .default)
        // Give session a task
        let task = session.dataTask(with: url) { (data, response, error) in

            if let error = error {
                delegate?.didFailWithError(error: error)
            }
            
            guard let safeData = data else { return }
            
            if let jokes = parseJSON(safeData) {
                delegate?.didUpdateJokesAgain(self, jokes: jokes)
            }
            
        }
        //Start the task
        task.resume()
    }
    
    func parseJSON(_ jokeData: Data) -> [String]? {
        let decoder = JSONDecoder()
        
        do {
            
            var jokesArray: [String] = []
            
            let decodedData = try decoder.decode(NetworkModel.self, from: jokeData)
            for (i, _) in decodedData.value.enumerated() {
                jokesArray.append(decodedData.value[i].joke.replacingOccurrences(of: "&quot;", with: "\""))
            }
            
            return jokesArray
            
        } catch {
            return nil
        }
    }
    
}
