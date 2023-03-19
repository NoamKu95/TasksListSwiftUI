//
//  BlankDarkView.swift
//  TasksList
//
//  Created by Noam Kurtzer on 19/03/2023.
//

import SwiftUI

struct BlankDarkView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(.black)
        .opacity(0.5)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankDarkView_Previews: PreviewProvider {
    static var previews: some View {
        BlankDarkView()
    }
}
