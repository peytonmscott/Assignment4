//
//  Authentication View.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .padding()
                .autocapitalization(.none)
            Button(action: authenticateUser) {
                Text("Sign In / Register")
            }
        }
        .padding()
    }
    
    private func authenticateUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error)")
                // Handle error and consider creating a new user if the user does not exist
            } else {
                print("User signed in successfully: \(result?.user.email ?? "")")
            }
        }
    }
    
    
    struct Authentication_View_Previews: PreviewProvider {
        static var previews: some View {
            Authentication_View()
        }
    }
}
