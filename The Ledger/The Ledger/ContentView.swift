import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    @State private var articles: [Article] = []
    @State private var isLoading: Bool = false
    
    private let newsService = NewsService.self
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 20)
                Text("empowering modern journalism")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .padding(.top, 10)
                Spacer()
                    .frame(height: 20)
                Image("bi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.top, 10)
                Spacer()
                    .frame(height: 35)
                HStack {
                    TextField("search headlines", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)
                    
                    Button("Search") {
                        search()
                    }
                    .buttonStyle(.borderedProminent)
                    
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
                
                if isLoading {
                    ProgressView("Fetching headlines...")
                    Spacer()
                } else if articles.isEmpty {
                    Text("enter a search term to load headlines.")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach($articles) { $article in
                            ArticleRowView(article: $article)
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        if articles.isEmpty && !searchText.isEmpty {
                            search()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    private func search() {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            articles = []
            return
        }

        Task {
            isLoading = true
            do {
                let fetchedArticles = try await newsService.searchArticles(query: searchText)
                articles = fetchedArticles
            } catch {
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
