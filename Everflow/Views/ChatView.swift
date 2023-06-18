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

    @State private var isActionSheetPresented = false
    
    @State private var messages = [
        ChatBox(id: 0, username: "Jane", content: "Hello, everyone!"),
        ChatBox(id: 1, username: "Ann", content: "Hi, Jane! Ready for the hackathon?"),
        ChatBox(id: 2, username: "Kaven", content: "Hello all! Yes, excited for the event."),
        ChatBox(id: 3, username: "Ann", content: "Definitely! I've got a lot of ideas."),
        ChatBox(id: 4, username: "Kaven", content: "Great, let's brainstorm together to find out the project we want to do the most! "),
        // Add more messages as needed...
    ]
    
    let fakeGpt = [
        "Kaven, I absolutely agree with your suggestion to brainstorm together - let's harness our collective creativity and find the perfect project that excites us all!",
        "I couldn't agree more, Kaven! Collaborative brainstorming is key to uncovering our best ideas and selecting the project that truly ignites our passion for the hackathon.",
        "You're absolutely right, Kaven! By joining forces and pooling our ideas, we can discover the project that resonates with all of us and maximize our chances of success in the hackathon."
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
                                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                            }
                        }
                    }
                }
            }
            Spacer()
            // Input field and send button
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    let newMessage = ChatBox(id: messages.count, username: currentUser, content: inputText)
                    messages.append(newMessage)
                    inputText = ""
                }) {
                    Text("Send")
                        .padding()
                        .background(Color(red: 1, green: 0.79, blue: 0.48))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                Button(action: {
                    isActionSheetPresented = true
                }) {
                    Text("GPT")
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
            .offset(y: -20)
            
            Spacer()
        }
        .background(Color(red: 1, green: 0.97, blue: 0.88))
        .ignoresSafeArea()
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(title: Text("Choose a suggestion"), buttons: fakeGpt.map { suggestion in
                .default(Text(suggestion)) { inputText = suggestion }
            } + [.cancel()])
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
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

