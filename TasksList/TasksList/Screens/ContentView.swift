//
//  ContentView.swift
//  TasksList
//
//  Created by Noam Kurtzer on 17/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var shouldShowAddTask : Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer(minLength: 80)
                    // MARK: - ADD TASK BTN
                    Button(action: {
                        shouldShowAddTask = true
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(backgroundGradientLeadingToTrailing.clipShape(Capsule()))
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
                    
                    // MARK: - LIST
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                            } label: {
                                VStack (alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text(item.timestamp!, formatter: itemFormatter)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 12)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.vertical, 0)
                }
                
                // MARK: - NEW TASK FORM
                if shouldShowAddTask {
                    NewTaskFormView()
                }
                
            } //: ZStack
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.gray)
                }
            } //: toolbar
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradientTopLeftToBottomRight.ignoresSafeArea(.all)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
