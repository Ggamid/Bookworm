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
    @State var sortType = 0
    
    
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books){book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
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
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
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

extension ContentView {
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}
