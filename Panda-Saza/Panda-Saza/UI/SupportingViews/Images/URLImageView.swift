//
//  URLImageView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/29.
//

import SwiftUI
import URLImage


struct URLImageView: View, Hashable {
    
    let url: URL
    let uuid: UUID = UUID()
    private let formatter: NumberFormatter
    
    init(urlString: String) {
        self.url = URL(string: urlString)!
        formatter = NumberFormatter()
        formatter.numberStyle = .percent
    }
    
    var body: some View {
        URLImage(url: url,
                 options: URLImageOptions(
                    identifier: uuid.uuidString,      // Custom identifier
                    expireAfter: 300.0,             // Expire after 5 minutes
                    cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25) // Return cached image or download after delay
                 ),
                 empty: {
                    ActivityIndicatorView().padding()
                    // This view is displayed before download starts
                 },
                 inProgress: { _ in
                    ActivityIndicatorView().padding()
                 },
                 failure: { error, retry in         // Display error and retry button
                    VStack {
                        Text(error.localizedDescription)
                        Button("Retry", action: retry)
                    }
                 },
                 content: { image in                // Content view
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 })
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "https://media.gucci.com/style/DarkGray_Center_0_0_1200x1200/1587569403/476433_DTDCT_1000_001_057_0000_Light-GG.jpg")
    }
}
