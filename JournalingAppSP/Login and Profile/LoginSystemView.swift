// Credit to https://www.youtube.com/watch?v=X3L9GLrWQqI

import SwiftUI
import Auth0

struct LoginSystemView: View {
    
    @State private var isAuthenticated = false
    @State private var userNeedsGoals = false
    @State var userProfile = Profile.empty
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some View {
        
        if isAuthenticated {
            if userNeedsGoals {
                GoalView(viewModel: JournalData(UserProfile: self.userProfile), userProfile: self.userProfile)
            } else {
                GoalView(viewModel: JournalData(UserProfile: self.userProfile), userProfile: self.userProfile)
                //ContentView(viewModel: JournalData(UserProfile: self.userProfile), userProfile: self.userProfile)
            }
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
                    self.userProfile = Profile.from(credentials.idToken)
                    let str = userProfile.id
                    let startIndex = str.index(str.startIndex, offsetBy: 6)
                    let substr = str[startIndex...]
                    let user = String(substr)
                    
                    // Check if user exists already or not
                    self.delegate.userExists(username: user) { exists in
                        if exists {
                            print("User exists -- No need to go to the Goal View")
                        } else {
                            print("User does not exist -- We need to go to the Goal View")
                            delegate.addNewUser(username: user)
                            self.userNeedsGoals = true
                            
                        }
                    }
                    self.isAuthenticated = true
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
