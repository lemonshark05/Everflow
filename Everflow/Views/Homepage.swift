//
//  Homepage.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Color.gray
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Foodie")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 250, maxHeight: 250)
                    .padding(.bottom, 50)
                
                Spacer()
                
                HStack(spacing: 20) {
                    NavigationLink(destination: LoginView()) {
                        Text("LOG IN")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .tracking(0.52)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 19)
                            .padding(.bottom, 18)
                            .frame(maxWidth: 150)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 1, green: 1, blue: 1), lineWidth: 2))
                    }
                    
                    NavigationLink(destination: SignupView()) {
                        Text("SIGN UP")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .tracking(0.52)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 19)
                            .padding(.bottom, 18)
                            .frame(maxWidth: 150)
                            .foregroundColor(.white)
                            .background(Color(red: 1, green: 0.79, blue: 0.48))
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 1, green: 0.79, blue: 0.48), lineWidth: 2))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
