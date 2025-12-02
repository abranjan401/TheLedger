import SwiftUI

// available bias lables for users to choose from
fileprivate let biasOptions = ["Neutral", "Liberal", "Conservative", "Libertarian", "Populist"]

struct ArticleRowView: View {
    
    // reference to the article model passed from the parent list
    @Binding var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                      
            // Display article title as a tappable link when URL is valid
            if let url = URL(string: article.url) {
                Link(destination: url) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                }
            } else {
                // Fallback for invalid or missing URL
                Text(article.title)
                    .font(.headline)
            }
            
            // Display article metadata (source + date)
            Text("Source: \(article.sourceName ?? "N/A") | Published: \(article.publishedAt.prefix(10))")
                .font(.caption)
                .foregroundColor(.gray)
            
            Divider()
             
            // Bias selection menu
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
            
            // Emotional tone scoring (Stepper: -2 to +2)
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
