import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var isSignUpMode = true  // Toggle between sign-up and sign-in
    @State private var errorMessage = ""  // State for error messages

    var body: some View {
        VStack {
            if userIsLoggedIn {
                ListView(userIsLoggedIn: $userIsLoggedIn)
            } else {
                content
            }
        }
    }

    var content: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(isSignUpMode ? "Sign Up" : "Sign In")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
                    .offset(x: 0, y: -100)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Email Address")
                        .foregroundColor(.white)
                        .font(.headline)
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white))
                        .foregroundColor(.white)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .foregroundColor(.white)
                        .font(.headline)
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.white))
                        .foregroundColor(.white)
                }
                .padding(.horizontal)

                // Show error message if there is one
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.body)
                        .padding(.top, 10)
                }

                Button(action: {
                    if isSignUpMode {
                        register()
                    } else {
                        login()
                    }
                }) {
                    Text(isSignUpMode ? "Sign Up" : "Sign In")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 100)

                Button(action: {
                    isSignUpMode.toggle()  // Toggle between sign-up and sign-in
                }) {
                    Text(isSignUpMode ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 100)
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn = true
                    }
                }
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Handle login errors
                errorMessage = error.localizedDescription
                print("Login error: \(error.localizedDescription)")  // For debugging
            } else {
                userIsLoggedIn = true
                errorMessage = ""  // Clear any error message on successful login
            }
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Handle registration errors
                errorMessage = error.localizedDescription
                print("Registration error: \(error.localizedDescription)")  // For debugging
            } else {
                userIsLoggedIn = true
                errorMessage = ""  // Clear any error message on successful registration
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
