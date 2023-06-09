//
//  Design.swift
//  TasksList
//
//  Created by Noam Kurtzer on 18/03/2023.
//

import SwiftUI

var IS_DARK_MODE = "is_dark_mode"

var backgroundGradientTopLeftToBottomRight: LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [.pink, .blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

var backgroundGradientLeadingToTrailing: LinearGradient {
    return LinearGradient(
        gradient: Gradient(colors: [.pink, .blue]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
