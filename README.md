<h1>Bias Beacon</h1>
<img width="300" height="300" alt="bi" src="https://github.com/user-attachments/assets/5088708d-6577-4b15-aa4a-269c89522e05" />

A news analysis tool!

**Project Summary:**
Bias Beacon is built using SwiftUI and the News API designed to 
engage users in critical analysis of contemporary journalism. Instead of passively 
reading headlines, users can actively assign local metrics such as **Political Bias** and 
**Emotional Tone** to each article, fostering media literacy and personal accountability in news consumption.

---

<h1>Summary</h1>
<h2>Core Requirements Met:</h2>

- API Integration: Fetches current and global news headlines based on user search queries from the News API. (Data from an API endpoint, Service Class)

- Reusable UI: Employs a ForEach loop and the dedicated ArticleRowView for efficient list rendering. (ForEach with reusable subviews)
  
- State Management: Utilizes @State (for managing the article list) and @Binding (for passing mutable analysis data to rows) to maintain local user ratings.
  
- User Input Components: Includes multiple user inputs: TextField (search input), Picker (for Bias), and Stepper (for Emotional Tone). (2+ unique user input components)

<h2>Other Fun Things!</h2>

- Full Article Access: Article titles are wrapped in a SwiftUI Link to immediately open the source URL in the user's external web browser.

- Home State Reset: The dedicated "Home" button quickly clears the search results and resets the input field.

<h2>Tools Used</h2>

Language: Swift 5.5+

Framework: SwiftUI

Networking: URLSession, Async/Await

APIs: NewsAPI [API Website](https://newsapi.org/)

---

<h1>Technical Breakdown</h1>
Data Models -> Article.swift contains the app's core model and the Codable structs (DecodableArticle, NewsResponse) required for JSON decoding.

Networking -> NewsService.swift uses a static function (searchArticles) to handle URLSession and data mapping, converting the raw API response to the [Article] array.

List Structure -> The ContentView uses a vertical VStack to position the custom title and logo above the scrollable List component.

---

<h1>Challenges Faced & Future Implementation</h1>
<h2>Challenges:</h2>
<h3>NavigationView Transparency</h3>
  Integrating the logo into the background was complex. 
  The solution required explicitly hiding the default opaque backgrounds of the NavigationView, 
  VStack, and List using a combination of background(Color.clear), .listStyle(.plain), 
  and .toolbarBackground(.hidden) to reveal the logo underneath.

<h3>Function Scope Error</h3>
  The asynchronous search() function initially caused compiler errors due to improper placement, 
  requiring verification that it was correctly defined within the ContentView struct.

<h2>Future Implementation:</h2>
- Having a bank to store the user's analyzed articles and ratings across app sessions
- Having a public type of forum for users to discuss articles with other users
- Having different screens such as home screen, main view, bank, public forum, etc..
  lends itself to also allowing users to have accounts to interact with other users

<h3>here is the home screen where 
    the user input text box is located, 
    alongside the home button (takes user back to screen), 
    and the app logo:</h3>
<img width="200" height="414" alt="home" src="https://github.com/user-attachments/assets/53e059e9-06ef-4dc5-bf36-d135b1cbe44d" />

<h3>here is a search query "politics" to which current articles are pulled from the API on the interface:</h3>
<img width="200" height="414" alt="search" src="https://github.com/user-attachments/assets/4db4f420-d780-41c8-8e5f-58819f99780a" />

<h3>here are the two ways users can select the ratings-- political bias and emotional tone:</h3>
<img width="250" height="61" alt="# rating" src="https://github.com/user-attachments/assets/77be7edb-ac05-4fe5-b532-c316430dd3b6" /> <img width="300" height="226" alt="bias rating" src="https://github.com/user-attachments/assets/7970dce2-75e1-44ad-9ad8-4defebf30eef" />

<h3>here the user is directly directed to the article by clicking on the link!</h3>
<img width="200" height="438" alt="article" src="https://github.com/user-attachments/assets/872e2189-1f88-450f-ba99-2d2c8eb18df6" />
