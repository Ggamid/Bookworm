//
//  ContentView.swift
//  Bookworm
//
//  Created by Gamıd Khalıdov on 01.06.2024.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List(books){ book in
                HStack{
                    EmojiRatingView(rating: book.rating)
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading){
                        Text(book.title)
                            .bold()
                        Text(book.author)
                    }
                }
                
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

#Preview {
    ContentView()
}
