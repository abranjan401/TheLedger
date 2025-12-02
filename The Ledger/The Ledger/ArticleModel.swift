import Foundation
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

struct DecodableArticle: Codable {
    let source: Source?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [DecodableArticle]
}
