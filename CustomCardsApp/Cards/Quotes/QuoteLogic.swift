//
//  QuoteLogic.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-15.
//

import SwiftUI

// MARK: - Response
struct QuoteResponse: Codable {
    let statusCode: Int
    let data: [Quote]
}

// Hosts all Quote properties
struct Quote: Codable, Hashable {
    var id: String
    var quoteText: String
    var quoteAuthor: String
    var quoteGenre: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quoteText, quoteAuthor, quoteGenre
    }
}

let placeholderQuote = Quote(id: "random", quoteText: "An awesome quote here.", quoteAuthor: "Mihajlo Mitrovic", quoteGenre: "Motivational")


/** Gets random quote (from a public online database) with author, and genre and converts it from JSON to the `Quote` class. This allows the app to hold over 80,000 quotes, without affecting the app size at all. */
func getRandomQuote(completion: @escaping (Quote) -> Void) {
    let config = URLSessionConfiguration.default // Setup web scraper
    config.allowsExpensiveNetworkAccess = true
    config.allowsCellularAccess = true
    config.waitsForConnectivity = false
    config.allowsConstrainedNetworkAccess = true
    let url = URL(string: "https://quote-garden.herokuapp.com/api/v3/quotes/random") // Url that returns random quotes in JSON

    var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
    request.httpMethod = "GET"

    let task = URLSession(configuration: config).dataTask(with: request) { data, response, error in
        guard let data = data else { // If data hasn't loaded, fail.
            print("Error 1: "+String(describing: error))
            return
        }

        guard let response = try? JSONDecoder().decode(QuoteResponse.self, from: data) else { // If JSON cannot be decoded, fail.
            print("Error 2: "+String(describing: error))
            return
        }
        DispatchQueue.main.async {
            completion(response.data[0])
        }
    }

    task.resume()
}
