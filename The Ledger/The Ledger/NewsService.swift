import Foundation

class NewsService {
    
    // IMPORTANT: Replace with your actual News API key
    private static let apiKey = "0742fdca352a4c4c957d1832594ee04c"
    private static let baseURL = "https://newsapi.org/v2"
    
    // The function is correctly declared to return your app's main model: [Article]
    static func searchArticles(query: String) async throws -> [Article] {
        
        // 1. URL Creation: Encode the query and use the /everything endpoint
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(baseURL)/everything?q=\(encodedQuery)&pageSize=20&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            // 2. Network Request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // Throw error for bad HTTP status codes
                throw URLError(.badServerResponse)
            }
            
            // 3. JSON Decoding
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            
            // 4. Mapping: Convert the API's DecodableArticle array to your app's Article array
            let mappedArticles = newsResponse.articles.map { apiArticle in
                Article(apiArticle: apiArticle)
            }
            
            // Optional: Debugging line to check results
            print("Successfully fetched \(mappedArticles.count) articles for query: \(query)")
            
            return mappedArticles
            
        } catch let error as URLError {
            // Error handling for network issues
            print("Network Request Error: \(error.localizedDescription)")
            throw error
        } catch let error as DecodingError {
            // Error handling for JSON Decoding issues
            print("Decoding Error: \(error.localizedDescription)")
            throw error
        } catch {
            // Catch all other unexpected errors
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
}
