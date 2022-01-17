//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Le Hoang Anh on 17/01/2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let safeData = data, error == nil {
                    let decoder = JSONDecoder()
                    
                    do {
                        let results = try decoder.decode(Results.self, from: safeData)
                        
                        DispatchQueue.main.async {
                            self.posts = results.hits
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
