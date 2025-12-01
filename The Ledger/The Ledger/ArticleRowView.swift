import SwiftUI

// The options for your Bias Picker (since enums are not used)
fileprivate let biasOptions = ["Neutral", "Liberal", "Conservative", "Libertarian", "Populist"]

struct ArticleRowView: View {
    
    // @Binding to the Article from the ContentView's @State array.
    // This allows changes made here to modify the original article object.
    @Binding var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // --- Article Info Section ---
            Text(article.title)
                .font(.headline)
            
            Text("Source: \(article.sourceName ?? "N/A") | Published: \(article.publishedAt.prefix(10))")
                .font(.caption)
                .foregroundColor(.gray)
            
            Divider()
            
            // --- User Analysis Section ---
            
            // 1. Picker (User Input Component #1: Bias)
            HStack {
                Text("Your Bias Analysis:")
                    .font(.subheadline)
                
                Picker("Bias", selection: $article.bias) { // Binding to article.bias (String)
                    ForEach(biasOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(5)
            }
            
            // 2. Stepper (User Input Component #2: Emotional Tone)
            HStack {
                // Display the current tone score
                Text("Emotional Tone (Score: \(article.emotionalTone))")
                    .font(.subheadline)
                
                // Stepper with a binding to article.emotionalTone (Int)
                // Range is set from -2 (Very Negative) to 2 (Very Positive)
                Stepper("", value: $article.emotionalTone, in: -2...2)
                    .labelsHidden() // Hide the default Stepper label
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 8)
    }
}
