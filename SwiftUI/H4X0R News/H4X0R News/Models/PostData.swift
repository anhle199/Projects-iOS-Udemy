//
//  PostData.swift
//  H4X0R News
//
//  Created by Le Hoang Anh on 17/01/2022.
//

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
