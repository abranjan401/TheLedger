import Foundation

// Main app-level Article model used throughout the UI

// Conforms to Identifiable to work easily with SwiftUI lists
struct Article: Identifiable {
    let id = UUID()
    
    // data from api
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let sourceName: String?
    let publishedAt: String
    
    // using String for Bias (ex. "Neutral", "Liberal")
    var bias: String = "Neutral"
    
    // using Int for Emotional Tone (ex. 0 for Neutral, -2 to 2)
    var emotionalTone: Int = 0
    
    // initializing
    init(apiArticle: DecodableArticle) {
        self.title = apiArticle.title
        self.description = apiArticle.description
        self.url = apiArticle.url
        self.urlToImage = apiArticle.urlToImage
        self.sourceName = apiArticle.source?.name
        self.publishedAt = apiArticle.publishedAt
    }
}

// Represents the raw article object received from the News API.
// This is decoded directly from JSON.
struct DecodableArticle: Codable {
    let source: Source?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// Nested API model representing an article's source information.
// (e.g., CNN, BBC, Reuters)
struct Source: Codable {
    let id: String?
    let name: String?
}

// Top-level response object returned by the News API.
// Contains metadata and an array of article objects.
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [DecodableArticle]
}
