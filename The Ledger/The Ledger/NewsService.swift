import Foundation

class NewsService {
    
    private static let apiKey = "0742fdca352a4c4c957d1832594ee04c"
    private static let baseURL = "https://newsapi.org/v2"
    
    static func searchArticles(query: String) async throws -> [Article] {
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(baseURL)/everything?q=\(encodedQuery)&pageSize=20&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            
            let mappedArticles = newsResponse.articles.map { apiArticle in
                Article(apiArticle: apiArticle)
            }
            
            print("Successfully fetched \(mappedArticles.count) articles for query: \(query)")
            
            return mappedArticles
            
        } catch let error as URLError {
            print("Network Request Error: \(error.localizedDescription)")
            throw error
        } catch let error as DecodingError {
            print("Decoding Error: \(error.localizedDescription)")
            throw error
        } catch {
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
}
