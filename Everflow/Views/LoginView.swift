//
//  LoginView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isLoading: Bool = false
    @State private var isLogged: Bool = false
    @State private var showalert = "Invalid email or password"
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        Image("login")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minHeight: 50, maxHeight: 60)
                            .padding(.leading, 0)
                            .padding(.bottom, 10)
                        
                        TextField("Email", text: $email)
                            .font(.subheadline)
                            .padding(.vertical, 17)
                            .padding(.leading, 17)
                            .frame(width: 343, height: 52)
                            .background(Color.white)
                            .border(Color(red: 0.30, green: 0.20, blue: 0.14), width: 2)
                            .padding(.bottom, 10)
                        
                        SecureField("Password", text: $password)
                            .font(.subheadline)
                            .padding(.vertical, 17)
                            .padding(.leading, 17)
                            .frame(width: 343, height: 52)
                            .background(Color.white)
                            .border(Color(red: 0.30, green: 0.20, blue: 0.14), width: 2)
                            .padding(.bottom, 13)
                        
                        if showError {
                            Text(showalert)
                                .foregroundColor(.red)
                                .padding(.bottom)
                        }
                        
                        Button(action: {
                            isLoading = true
                            LoginController.login(email: email, password: password) { result in
                                isLoading = false
                                switch result {
                                case .success:
                                    showError = false
                                    isLogged = true // set the isLogged state variable to true
                                    DispatchQueue.main.async {
                                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                              let window = windowScene.windows.first else {
                                            return
                                        }
                                        
                                        let rolePageView = RolePageView()
                                        window.rootViewController = UIHostingController(rootView: rolePageView)
                                        window.makeKeyAndVisible()
                                    }
                                case .failure:
                                    showError = true
                                    showalert = "Invalid email or password"
                                    if email.isEmpty{
                                        showalert = "Please enter your email."
                                    }
                                    if password.isEmpty{
                                        showalert = "Please enter your password."
                                    }
                                }
                            }
                        }) {
                            Text("LOG IN")
                                .fontWeight(.bold)
                                .font(.system(size: 18))
                                .tracking(0.52)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 19)
                                .padding(.bottom, 18)
                                .frame(width: 343, height: 52)
                                .foregroundColor(.black)
                                .background(Color(red: 1, green: 0.79, blue: 0.48))
                                .cornerRadius(6)
                                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 1, green: 0.79, blue: 0.48), lineWidth: 2))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, geometry.safeAreaInsets.top + 40)
                    Spacer()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
