#### How to Run
1.	Clone the repository:
      git clone https://github.com/CodingSahil/magic_slides.git
      cd magic_slides
2. Install dependencies:
      flutter pub get
3. Run the project:
      flutter run


#### Database Used

✔ Supabase Authentication

Used for:
- Signup (email + password)
- Login
- Persistent session handling
No additional tables required; authentication is handled entirely by Supabase Auth.

- for Testing Purpose, i used below credentials to login
  - Email: chandwanisahil10@gmail.com
  - Password: Sahil@10

#### Architecture

The project follows a service-driven architecture for clean separation between UI and logic


#### Known Issues

- MagicSlides API delay: PPT generation takes 5–20 seconds depending on complexity
- Google Docs Viewer limitations: Complex PPT layouts may not fully render
- Scoped storage restrictions: Android 11+ saves downloaded files in app-specific directory
- Internet dependency: MagicSlides API requires an active internet connection
- WebView PDF preview limitations: WebView preview may vary slightly across Android versions

