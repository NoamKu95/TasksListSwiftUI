//
//  Formatters.swift
//  TasksList
//
//  Created by Noam Kurtzer on 18/03/2023.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
