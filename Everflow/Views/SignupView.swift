//
//  SignupView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct SignupView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading) {
                    Image("signup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 50, maxHeight: 60)
                        .padding(.leading, 0)
                        .padding(.bottom, 10)
                    
                    TextField("Username", text: $username)
                        .font(.subheadline)
                        .padding(.vertical, 17)
                        .padding(.leading, 17)
                        .frame(width: 343, height: 52)
                        .background(Color.white)
                        .border(Color(red: 0.30, green: 0.20, blue: 0.14), width: 2)
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
                        .padding(.bottom, 10)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .font(.subheadline)
                        .padding(.vertical, 17)
                        .padding(.leading, 17)
                        .frame(width: 343, height: 52)
                        .background(Color.white)
                        .border(Color(red: 0.30, green: 0.20, blue: 0.14), width: 2)
                        .padding(.bottom, 13)

                    Button(action: signUp) {
                        Text("SIGN UP")
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
                .padding(.top, geometry.safeAreaInsets.top + 40) // Adjust padding as needed
                Spacer()
            }
        }
    }
    func signUp(){
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
