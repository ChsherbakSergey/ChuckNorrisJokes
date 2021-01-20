//
//  NetworkModel.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import Foundation

struct NetworkModel: Decodable {
    let value: [Joke]
}

struct Joke: Decodable {
    let joke: String
}
