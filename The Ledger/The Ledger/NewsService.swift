import Foundation

// Service responsible for getting news data from the news API
class NewsService {
    
    // API authentication key
    private static let apiKey = "0742fdca352a4c4c957d1832594ee04c"
    
    // base URL for the news API
    private static let baseURL = "https://newsapi.org/v2"
    
    // performs a search request for articles matching the given query
    static func searchArticles(query: String) async throws -> [Article] {
        
        // prepare the query and construct the endpoint URL
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(baseURL)/everything?q=\(encodedQuery)&pageSize=20&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            // execute the network request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response status code
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            // Decode the JSON response into model objects
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            
            // Convert API-specific article objects to app-specific Article models
            let mappedArticles = newsResponse.articles.map { apiArticle in
                Article(apiArticle: apiArticle)
            }
            
            print("Successfully fetched \(mappedArticles.count) articles for query: \(query)")
            
            return mappedArticles
            
        } catch let error as URLError {
            // handles network error
            print("Network Request Error: \(error.localizedDescription)")
            throw error
        } catch let error as DecodingError {
            // handle JSON decoding errors
            print("Decoding Error: \(error.localizedDescription)")
            throw error
        } catch {
            // catch-al for unexpected errors
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
}
