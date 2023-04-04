// Credit to https://www.youtube.com/watch?v=X3L9GLrWQqI

import SwiftUI
import Auth0

struct LoginSystemView: View {
    
    @State private var isAuthenticated = true
    @State var userProfile = Profile.empty
    
    /**
     If the user is authenticated, it navigates to the homepage (ContentView)
     */
    var body: some View {
        
        if isAuthenticated {
            ContentView(viewModel: JournalData(), userProfile: self.userProfile)
        } else {
            
            VStack {
        
                Button("Log in") {
                    login()
                }
                .buttonStyle(MyButtonStyle())
                
            } // VStack
            
        } // if isAuthenticated
        
    } // body
    
    struct UserImage: View {
        // Given the URL of the user’s picture, this view asynchronously
        // loads that picture and displays it. It displays a “person”
        // placeholder image while downloading the picture or if
        // the picture has failed to download.
        
        var urlString: String
        
        var body: some View {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .frame(maxWidth: 128)
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 128)
                    .foregroundColor(.blue)
                    .opacity(0.5)
            }
            .padding(40)
        }
    }
    
    
    // MARK: View modifiers
    // --------------------
    
    struct TitleStyle: ViewModifier {
        let titleFontBold = Font.title.weight(.bold)
        
        func body(content: Content) -> some View {
            content
                .font(titleFontBold)
                .foregroundColor(CustomColor.darkButtonColor)
                .padding()
        }
    }
    
    struct MyButtonStyle: ButtonStyle {
        let darkColor = CustomColor.darkButtonColor
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(darkColor)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
}

extension LoginSystemView {
    
    private func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                    
                case .success(let credentials):
                    self.isAuthenticated = true
                    self.userProfile = Profile.from(credentials.idToken)
                }
            }
    }
    
    private func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                
                switch result {
                case .failure(let error):
                    print("Failed with: \(error)")
                    
                case .success:
                    self.isAuthenticated = false
                    self.userProfile = Profile.empty
                }
                
            }
    }
    
}




struct LoginSystemView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSystemView()
    }
}