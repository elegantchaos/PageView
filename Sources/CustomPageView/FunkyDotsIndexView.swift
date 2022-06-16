// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 16/06/22.
//  All code (c) 2022 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import SwiftUI

struct FunkyDotsIndexView: View {
    
    // MARK: - Public Properties
    
    let currentIndex: Int
    let pageCount: Int
    let maxDots: Int?
    
    // MARK: - Drawing Constants
    
    private let circleSize: CGFloat = 16
    private let circleSpacing: CGFloat = 12
    
    private let primaryColor = Color.white
    private let secondaryColor = Color.white.opacity(0.6)
    
    private let smallScale: CGFloat = 0.6
    
    init(currentIndex: Int, pageCount: Int, maxDots: Int? = nil) {
        self.currentIndex = currentIndex
        self.pageCount = pageCount
        self.maxDots = maxDots
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: circleSpacing) {
            ForEach(pageRange, id: \.self) { index in // 1
                Circle()
                    .fill(currentIndex == index ? primaryColor : secondaryColor) // 2
                    .scaleEffect(currentIndex == index ? 1 : smallScale)
                
                    .frame(width: circleSize, height: circleSize)
                
                    .transition(AnyTransition.opacity.combined(with: .scale)) // 3
                
                    .id(index) // 4
            }
        }
    }
    
    var pageRange: Range<Int> {
        if let maxDots = maxDots {
            let startIndex = currentIndex - (maxDots / 2)
            let endIndex = startIndex + maxDots
            return startIndex..<endIndex
        } else {
            return 0..<pageCount
        }
    }
}
