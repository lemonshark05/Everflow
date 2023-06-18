//
//  ChatView.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatController = ChatController()
    @State private var inputText: String = ""
    let currentUser: String = "Ann"

    @State private var isSheetPresented = false
    
    @State private var messages = [
        ChatBox(id: 0, username: "Jane", content: "Hello, everyone!"),
        ChatBox(id: 1, username: "Ann", content: "Hi, Ready for the hackathon?"),
        ChatBox(id: 2, username: "Kaven", content: "Hello all! Yes, excited for the event."),
        ChatBox(id: 3, username: "Ann", content: "Definitely! I've got a lot of ideas."),
        ChatBox(id: 4, username: "Kaven", content: "Great, let's brainstorm together to find out the project we want to do the most! "),
        // Add more messages as needed...
    ]
    
    let fakeGpt = [
        "Kaven, I absolutely agree with your suggestion to brainstorm together!",
        "I couldn't agree more, Kaven! Collaborative brainstorming is key to uncovering our best ideas for the hackathon.",
        "You're absolutely right, Kaven! By joining forces and pooling our ideas, we can maximize our chances of success in the hackathon."
    ]
    
    var body: some View {
        VStack {
            Spacer()
            VStack { // Add a VStack to hold the Text("Group1") and ScrollView
                Text("Group1")
                    .font(.title)
                    .foregroundColor(.brown)
                    .padding()
                    .offset(y: 20)
                Divider()
                
                ScrollView {
                    LazyVStack { // Set spacing to 0 to eliminate vertical spacing between messages
                        ForEach(messages.indices, id: \.self) { index in
                            withAnimation(Animation.spring().delay(Double(index) * 0.5)) {
                                MessageRow(message: messages[index], currentUser: currentUser)
                                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity)).id(index)
                            }
                        }
                    }
                }
            }
            Spacer()
            // Input field and send button
            TextView(text: $inputText)
            HStack {
//                TextField("Type a message...", text: $inputText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.leading)
                Button(action: {
                    let newMessage = ChatBox(id: messages.count, username: currentUser, content: inputText)
                    messages.append(newMessage)
                    inputText = ""
                }) {
                    Text("Send")
                        .padding(10)
                        .background(Color(red: 1, green: 0.79, blue: 0.48))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                Button(action: {
                    isSheetPresented = true
                }) {
                    Text("GPT")
                        .padding(10)
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
            
            Spacer()
        }
        .background(Color(red: 1, green: 0.97, blue: 0.88))
        .ignoresSafeArea()
        .sheet(isPresented: $isSheetPresented) {
            NavigationView {
                    VStack {
                        ScrollView {
                            ForEach(fakeGpt, id: \.self) { suggestion in
                                Text(suggestion)
                                    .font(.title2) // You can adjust this to your needs
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        inputText = suggestion
                                        isSheetPresented = false
                                    }
                            }
                        }
                        Spacer()
                    }
                    .navigationBarTitle("GPT Suggestions", displayMode: .inline)
                    .navigationBarItems(trailing: Button("Cancel") {
                        isSheetPresented = false
                    })
                    .padding()
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

struct TextView: View {
    @Binding var text: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text("Type a message...")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }

                    TextEditor(text: $text)
                        .padding(.leading)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            }
        }
        .frame(height: 60)
    }
}

struct MessageRow: View {
    var message: ChatBox
    var currentUser: String

    var body: some View {
        HStack(alignment: .top) {
            if message.username != currentUser {
                HStack(spacing: 5) {
                    VStack {
                        Image("\(message.username)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text(message.username)
                            .font(.headline)
                            .foregroundColor(.brown)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(message.content)
                            .font(.headline)
                    }
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .layoutPriority(1)
                }
            } else {
                HStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        Text(message.content)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .padding(8)
                    .background(Color(red: 1, green: 0.79, blue: 0.48).opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .layoutPriority(1)

                    VStack {
                        Image("\(message.username)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                        Text(message.username)
                            .font(.headline)
                            .foregroundColor(.brown)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: message.username == currentUser ? .trailing : .leading)
    }
}

