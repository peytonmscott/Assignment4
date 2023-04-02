//
//  ContentViewModel.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import Foundation
import FirebaseFirestore

class ContentViewModel: ObservableObject {
    @Published var pictures: [Picture] = []
    init() {
        fetchPictures()
    }

    private func fetchPictures() {
        Firestore.firestore()
            .collection("pictures")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.pictures = documents.compactMap { queryDocumentSnapshot -> Picture? in
                    return try? queryDocumentSnapshot.data(as: Picture.self)
                }
            }
    }

}
