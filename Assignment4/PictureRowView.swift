//
//  PictureRowView.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import SwiftUI
import SwiftUI
import SDWebImageSwiftUI

struct PictureRowView: View {
    var picture: Picture

    var body: some View {
        HStack {
            WebImage(url: URL(string: picture.imageURL))
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(picture.notes)
                    .fontWeight(.bold)
                Text("Uploaded on: \(picture.timestamp.formatted())")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}


struct PictureRowView_Previews: PreviewProvider {
    static var previews: some View {
        PictureRowView(picture: Picture)
    }
}
