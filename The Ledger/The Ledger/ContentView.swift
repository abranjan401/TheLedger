import SwiftUI

struct ContentView: View {
    
    // stores user-entered search entry
    @State private var searchText: String = ""
    
    //list of articles returned by the API
    @State private var articles: [Article] = []
    
    // loading indicated visibility
    @State private var isLoading: Bool = false
    
    // reference to the news API service
    private let newsService = NewsService.self
    
    var body: some View {
        NavigationView {
            VStack {
                // app header
                Spacer()
                    .frame(height: 20)
                Text("empowering modern journalism")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .padding(.top, 10)
                Spacer()
                    .frame(height: 20)
                // logo image
                Image("bi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top, 10)
                Spacer()
                    .frame(height: 35)
                // search bar + buttons
                HStack {
                    // input field for search query
                    TextField("search headlines", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)
                    // triggers the search request
                    Button("Search") {
                        search()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // clears search request + resets view
                    Button {
                        searchText = ""
                        articles = []
                        isLoading = false
                    } label: {
                        Image(systemName: "house.fill").padding(.horizontal, 4)
                    }
                    .buttonStyle(.bordered)
                    .padding(.trailing)
                }
                // shows loading indicator while getting data
                if isLoading {
                    ProgressView("Fetching headlines...")
                    Spacer()
                    // placeholder when no articles have been loaded
                } else if articles.isEmpty {
                    Text("enter a search term to load headlines.")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                    // display the article list based on search entry
                } else {
                    List {
                        ForEach($articles) { $article in
                            ArticleRowView(article: $article)
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        // automatically runs search when returning to view
                        if articles.isEmpty && !searchText.isEmpty {
                            search()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    // getting articles from the API based on the search keywords
    private func search() {
        // preventing empty searches
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            articles = []
            return
        }

        Task {
            isLoading = true
            do {
                // calling the news API service
                let fetchedArticles = try await newsService.searchArticles(query: searchText)
                articles = fetchedArticles
            } catch {
                // logging errors and reseting the UI state
                print("Failed to fetch articles: \(error.localizedDescription)")
                articles = []
            }
            isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
