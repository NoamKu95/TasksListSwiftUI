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
    
    @AppStorage(IS_DARK_MODE) private var isDarkMode: Bool = false
    @State private var shouldShowAddTask: Bool = false
    
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
                    HStack (spacing: 10) {
                        Text("Daily Tasks")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(.white, lineWidth: 2)
                            )
                        
                        Button(action: {
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                        }) {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    
                    Spacer(minLength: 80)
                    
                    
                    // MARK: - ADD TASK BTN
                    Button(action: {
                        shouldShowAddTask = true
                        playSound(sound: "sound-ding", type: "mp3")
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
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 12)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.vertical, 0)
                }
                .blur(radius: shouldShowAddTask ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: - NEW TASK FORM
                if shouldShowAddTask {
                    BlankDarkView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5
                    )
                        .onTapGesture {
                            withAnimation() {
                                shouldShowAddTask = false
                            }
                        }
                    NewTaskFormView(isShowing: $shouldShowAddTask)
                }
                
            } //: ZStack
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: shouldShowAddTask ? 8.0 : 0, opaque: false)
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
