//
//  ContentView.swift
//  Shared
//
//  Created by Fernando May on 22/06/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
   @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Añade una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                Button("Crear") {
	                notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = "".padding()
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                Spacer()
                List {
                    ForEach(notesViewModel.notes, id: \.id) { nota in
                        HStack {
                            Text(nota.description)
                        }
                        if nota.isFavorited {
                            Text("❤️")
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: $nota)
                            } label: {
                                Label("Favorito", systemImage: "heart.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                notesViewModel.removeNote(withId: nota.id)
                            } label: {
                                Label("Borrar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Qualtop todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Text(notesViewModel.getNumberOfNotes())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//  @Environment(\.managedObjectContext) private var viewContext

//     @FetchRequest(
//         sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//         animation: .default)
//     private var items: FetchedResults<Item>

//     var body: some View {
//         NavigationView {
//             List {
//                 ForEach(items) { item in
//                     NavigationLink {
//                         Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                     } label: {
//                         Text(item.timestamp!, formatter: itemFormatter)
//                     }
//                 }
//                 .onDelete(perform: deleteItems)
//             }
//             .toolbar {
// #if os(iOS)
//                 ToolbarItem(placement: .navigationBarTrailing) {
//                     EditButton()
//                 }
// #endif
//                 ToolbarItem {
//                     Button(action: addItem) {
//                         Label("Add Item", systemImage: "plus")
//                     }
//                 }
//             }
//             Text("Select an item")
//         }
//     }

//     private func addItem() {
//         withAnimation {
//             let newItem = Item(context: viewContext)
//             newItem.timestamp = Date()

//             do {
//                 try viewContext.save()
//             } catch {
//                 // Replace this implementation with code to handle the error appropriately.
//                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                 let nsError = error as NSError
//                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//             }
//         }
//     }

//     private func deleteItems(offsets: IndexSet) {
//         withAnimation {
//             offsets.map { items[$0] }.forEach(viewContext.delete)

//             do {
//                 try viewContext.save()
//             } catch {
//                 // Replace this implementation with code to handle the error appropriately.
//                 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                 let nsError = error as NSError
//                 fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//             }
//         }
//     }
// }

// private let itemFormatter: DateFormatter = {
//     let formatter = DateFormatter()
//     formatter.dateStyle = .short
//     formatter.timeStyle = .medium
//     return formatter
// }()