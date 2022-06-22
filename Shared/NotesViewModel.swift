//
//  NoteModel.swift
//  Shared
//
//  Created by Fernando May on 22/06/22.
//

import Foundation

final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    
    private let userDefaults: UserDefaults = .standard
    
    init() {
        notes = getAllNotes()
    }
    
    func saveNote(description: String) {
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = userDefaults.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData) {
                return notes
            }
        }
        return []
    }

    func removeNote(withId id: String) {
        notes.removeAll(where: { $0.id == id })
        encodeAndSaveAllNotes()
    }

     func updateFavoriteNote(note: Binding<NoteModel>) {
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
    }

    func getNumberOfNotes() -> String {
    "\(notes.count)"
}
}