<h1>Bias Beacon</h1>
<img width="500" height="500" alt="bi" src="https://github.com/user-attachments/assets/5088708d-6577-4b15-aa4a-269c89522e05" />

A news analysis tool!

**Project Summary:**
Bias Beacon is built using SwiftUI and the News API designed to 
engage users in critical analysis of contemporary journalism. Instead of passively 
reading headlines, users can actively assign local metrics such as **Political Bias** and 
**Emotional Tone** to each article, fostering media literacy and personal accountability in news consumption.
<img width="373" height="600" alt="Screenshot 2025-12-02 at 1 29 39 AM" src="https://github.com/user-attachments/assets/6c831940-0c43-4f56-a785-478bb91b43d7" />
<img width="373" height="600" alt="Screenshot 2025-12-02 at 1 30 24 AM" src="https://github.com/user-attachments/assets/c443df34-82a0-4bad-b229-514f577a23ea" />
<img width="373" height="200" alt="Screenshot 2025-12-02 at 1 31 03 AM" src="https://github.com/user-attachments/assets/0edf2519-bf85-4c6d-858c-39586efeef57" />
<img width="349" height="60" alt="Screenshot 2025-12-02 at 1 31 28 AM" src="https://github.com/user-attachments/assets/c762c05e-d204-44be-b324-e06b1d0a219e" />
<img width="349" height="700" alt="Screenshot 2025-12-02 at 1 32 04 AM" src="https://github.com/user-attachments/assets/a70e10e9-4dbf-4b22-bbc5-8875eb426597" />

<video src="https://drive.google.com/file/d/1SyTNQYFg6B33r4hvo0vgjzwsrsKe6qFi/view?usp=sharing" controls>
    Your browser does not support the video tag.
</video>

---

**Summary**
Core Requirements Met:
- API Integration: Fetches current and global news headlines based on user search queries from the News API. (Data from an API endpoint, Service Class)
- Reusable UI: Employs a ForEach loop and the dedicated ArticleRowView for efficient list rendering. (ForEach with reusable subviews)
- State Management: Utilizes @State (for managing the article list) and @Binding (for passing mutable analysis data to rows) to maintain local user ratings.
- User Input Components: Includes multiple user inputs: TextField (search input), Picker (for Bias), and Stepper (for Emotional Tone). (2+ unique user input components)

Other Fun Things!
- Full Article Access: Article titles are wrapped in a SwiftUI Link to immediately open the source URL in the user's external web browser.
- Home State Reset: The dedicated "Home" button quickly clears the search results and resets the input field.

---

**Technical Breakdown**
Data Models -> Article.swift contains the app's core model and the Codable structs (DecodableArticle, NewsResponse) required for JSON decoding.
Networking -> NewsService.swift uses a static function (searchArticles) to handle URLSession and data mapping, converting the raw API response to the [Article] array.
List Structure -> The ContentView uses a vertical VStack to position the custom title and logo above the scrollable List component.

---

**Challenges Faced & Future Implementation**
challenges:
**NavigationView Transparency** 
  Integrating the logo into the background was complex. 
  The solution required explicitly hiding the default opaque backgrounds of the NavigationView, 
  VStack, and List using a combination of background(Color.clear), .listStyle(.plain), 
  and .toolbarBackground(.hidden) to reveal the logo underneath.

**Function Scope Error**
  The asynchronous search() function initially caused compiler errors due to improper placement, 
  requiring verification that it was correctly defined within the ContentView struct.

future implementation:
- Having a bank to store the user's analyzed articles and ratings across app sessions
- Having a public type of forum for users to discuss articles with other users
- Having different screens such as home screen, main view, bank, public forum, etc..
  lends itself to also allowing users to have accounts to interact with other users
