import SwiftUI

struct ContentView: View {
    
    // @State Properties
    @State private var searchText: String = "politics" // Default search term
    @State private var articles: [Article] = [] // The data source
    @State private var isLoading: Bool = false
    
    // Service Instance
    private let newsService = NewsService.self
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Search Bar, Search Button, and Home Button (TextField with Binding)
                HStack {
                    // 1. Search TextField
                    TextField("Search headlines (e.g., 'economy', 'space')", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)
                    
                    // 2. Search Button
                    Button("Search") {
                        // Action: Trigger the asynchronous network request
                        search()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // 3. Home/Clear Button
                    Button {
                        // Action: Reset the search term and clear the article list
                        searchText = ""
                        articles = []
                        isLoading = false
                    } label: {
                        Image(systemName: "house.fill")
                            .padding(.horizontal, 4)
                    }
                    .buttonStyle(.bordered)
                    .padding(.trailing)
                }
                
                // Article List Display
                if isLoading {
                    ProgressView("Fetching headlines...")
                } else if articles.isEmpty {
                    Text("Enter a search term and tap 'Search' to load headlines.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        // ForEach with Reusable Subviews (ArticleRowView)
                        // '$article' passes the @Binding to the row view
                        ForEach($articles) { $article in
                            ArticleRowView(article: $article)
                        }
                    }
                    // Fix for infinite loop: Only search on appear if the list is empty
                    .onAppear {
                        if articles.isEmpty && !searchText.isEmpty {
                            search()
                        }
                    }
                }
            }
            .navigationTitle("Bias Beacon 🚨")
        }
    }
    
    // Function to handle the async network call
    private func search() {
        // Ensure we only search if the text is not empty
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            articles = []
            return
        }

        // Run the async networking code on a background Task
        Task {
            isLoading = true
            do {
                // Call the static function in your NewsService
                let fetchedArticles = try await newsService.searchArticles(query: searchText)
                
                // Update the @State array on the main thread
                articles = fetchedArticles
            } catch {
                // Handle errors
                print("Failed to fetch articles: \(error.localizedDescription)")
                articles = [] // Clear articles on failure
            }
            isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
