//
//  DetailView.swift
//  Bookworm
//
//  Created by Gamıd Khalıdov on 02.06.2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    let book: Book
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
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

            Text(book.review)
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.large)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
