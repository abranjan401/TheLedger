import SwiftUI

fileprivate let biasOptions = ["Neutral", "Liberal", "Conservative", "Libertarian", "Populist"]

struct ArticleRowView: View {
    
    // @Binding to the Article from the ContentView's @State array.
    @Binding var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // --- Article Info Section ---
            
            // 1. THE ADDED FEATURE: Wrap the Title in a Link
            if let url = URL(string: article.url) {
                Link(destination: url) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.blue) // Indicate it's a link
                        .multilineTextAlignment(.leading)
                }
            } else {
                // Fallback if the URL is invalid
                Text(article.title)
                    .font(.headline)
            }
            
            Text("Source: \(article.sourceName ?? "N/A") | Published: \(article.publishedAt.prefix(10))")
                .font(.caption)
                .foregroundColor(.gray)
            
            Divider()
            
            // --- User Analysis Section ---
            
            HStack {
                Text("Your Bias Analysis:")
                    .font(.subheadline)
                
                Picker("Bias", selection: $article.bias) {
                    ForEach(biasOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(5)
            }
            
            HStack {
                Text("Emotional Tone (Score: \(article.emotionalTone))")
                    .font(.subheadline)
                
                Stepper("", value: $article.emotionalTone, in: -2...2)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 8)
    }
}
