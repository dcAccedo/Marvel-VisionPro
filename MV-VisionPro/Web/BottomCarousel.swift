//
//  BottomCarousel.swift
//  MV-VisionPro
//
//  Created by Daniel Coria on 29/08/23.
//

import SwiftUI

struct Images: Identifiable {
    var id = UUID()
    var name: String
}

struct BottomCarousel: View {
    
    let localImages: [Images] = [
        Images(name: "image-1"),
        Images(name: "image-2"),
        Images(name: "image-3"),
        Images(name: "image-4"),
        Images(name: "image-5"),
        Images(name: "image-1"),
        Images(name: "image-2"),
        Images(name: "image-3"),
        Images(name: "image-4"),
        Images(name: "image-5")
    ]
                  
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Moments")
            Spacer()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(localImages, id: \.id) { item in
                        Image(item.name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 170)
                            .cornerRadius(20)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 6)
                            
                    }
                }
            }
            Spacer()
        }
        .padding()
        .glassBackgroundEffect()
        .frame(height: 300)
    }
}

#Preview {
    BottomCarousel()
}
