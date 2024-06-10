//
//  DetailView.swift
//  Bookworm
//
//  Created by Gamıd Khalıdov on 02.06.2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var showingAlert = false
    
    @Bindable var book: Book
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(genres.firstIndex(of: book.genre) != nil ? book.genre : "Default")
                    .resizable()
                    .scaledToFit()
                
                LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .center)
                VStack(alignment: .leading){
                    Text(book.genre)
                        .fontWeight(.black)
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text("genre")
                        .foregroundStyle(.white)
                        .padding(.top, -25)
                        .fontWeight(.thin)
                }
                .padding(8)
                .offset(x: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.date, format: Date.FormatStyle().year().month().day().hour().minute())
                .foregroundStyle(.gray)
            
            TextField(book.review, text: $book.review, axis: .vertical)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
                

            
            RatingView(rating: $book.rating)
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.large)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar{
            ToolbarItem{
                Button("delete", systemImage: "trash") { showingAlert.toggle() }
            }
        }
        .alert("Delete Book", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { 
                modelContext.delete(book)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations:  config)
        let example = Book(title: "Test Book", author: "Test Author", genre:    "Fantasy", review: "This was a great book; I really enjoyed it.",   rating: 4)
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
