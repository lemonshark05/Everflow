//
//  RolePageView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct RolePageView: View {
    @State private var selection = 2
    let tabBarIcons = ["person.crop.circle", "flag.circle", "plus.circle.fill", "checkmark.circle", "person.crop.circle"]
    let tabBarLabels = ["Attributes", "Activities", "", "ToDo", "Settings"]
    let tabBarColors: [Color] = [Color(red: 0.97, green: 0.70, blue: 0.37), Color(red: 0.97, green: 0.70, blue: 0.37), Color(red: 0.97, green: 0.70, blue: 0.37), .blue, Color(red: 0.97, green: 0.70, blue: 0.37)]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            customTabView
            customTabBar
        }
    }
    
    private var customTabView: some View {
        TabView(selection: $selection) {
            UserView()
                .tag(0)
            
            NetworkView()
                .tag(1)
            
            ChatView()
                .tag(2)
            
            SettingView()
                .tag(3)
            
            AssistantView()
                .tag(4)
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
    
    private var customTabBar: some View {
        VStack(spacing: 0) {
            Divider().padding(.horizontal, 15)
            HStack(spacing: 0) {
                ForEach(0..<5) { index in
                    if index == 2 {
                        tabBarButton(index: index, customColor: true)
                    } else {
                        tabBarButton(index: index, customColor: false)
                    }
                }
            }
            .frame(height: 60)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(.horizontal, 15)
            .padding(.bottom, 0)
            .padding(.trailing, 5)
        }
    }
    
    private func tabBarButton(index: Int, customColor: Bool) -> some View {
        Button(action: {
            selection = index
        }) {
            VStack {
                Image(systemName: tabBarIcons[index])
                    .font(index == 2 ? .system(size: 48) : .system(size: 32))
                Text(tabBarLabels[index])
                    .font(index == 2 ? .system(size: 0) : .system(size: 12))
            }
            .foregroundColor(customColor ? Color(red: 0.99, green: 0.79, blue: 0.49) : (selection == index ? tabBarColors[index] : .gray))
            .frame(maxWidth: .infinity)
        }
    }
}

struct RolePageView_Previews: PreviewProvider {
    static var previews: some View {
        RolePageView()
    }
}
