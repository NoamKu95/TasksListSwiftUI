//
//  NewTaskFormView.swift
//  TasksList
//
//  Created by Noam Kurtzer on 19/03/2023.
//

import SwiftUI

struct NewTaskFormView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var task: String = ""
    private var isSaveBtnDisabled: Bool {
        task.isEmpty
    }
    
    @Binding var isShowing: Bool
    @AppStorage(IS_DARK_MODE) private var isDarkMode: Bool = false
    
    // MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newTask = Item(context: viewContext)
            newTask.timestamp = Date()
            newTask.task = task
            newTask.id = UUID()
            newTask.completion = false
            
            do {
                try viewContext.save()
                task = ""
                hideKeyboard()
                isShowing = false
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                }) {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isSaveBtnDisabled)
                .padding()
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background(isSaveBtnDisabled ? .gray : .pink)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color.black : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue:0, opacity: 0.65), radius: 24)
        }
        .padding()
    }
}

struct NewTaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskFormView(isShowing: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .background(.pink)
        
    }
}
