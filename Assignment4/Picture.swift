//
//  Picture.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import Foundation
import FirebaseFirestore

struct Picture: Identifiable {
    var id: String
    var imageURL: String
    var notes: String
    var timestamp: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case notes
        case timestamp
    }
    
    init(id: String, imageURL: String, notes: String, timestamp: Timestamp) {
        self.id = id
        self.imageURL = imageURL
        self.notes = notes
        self.timestamp = timestamp
    }
    
    init?(from document: QueryDocumentSnapshot) {
        guard let imageURL = document.get("image_url") as? String,
              let notes = document.get("notes") as? String,
              let timestamp = document.get("timestamp") as? Timestamp else { return nil }
        
        self.id = document.documentID
        self.imageURL = imageURL
        self.notes = notes
        self.timestamp = timestamp
    }
}
