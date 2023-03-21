//
//  BlankDarkView.swift
//  TasksList
//
//  Created by Noam Kurtzer on 19/03/2023.
//

import SwiftUI

struct BlankDarkView: View {
    
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankDarkView_Previews: PreviewProvider {
    static var previews: some View {
        BlankDarkView(backgroundColor: .black, backgroundOpacity: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradientTopLeftToBottomRight)
    }
}
