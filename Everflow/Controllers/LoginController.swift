//
//  LoginController.swift
//  Everflow
//
//  Created by lemonshark on 2023/6/17.
//

import Foundation

class LoginController {
    static func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Perform some basic input validation
        guard !email.isEmpty else {
            completion(.failure(LoginError.emptyEmail))
            return
        }
        guard !password.isEmpty else {
            completion(.failure(LoginError.emptyPassword))
            return
        }

        // Configure the MongoDB client
        let connectionString = "mongodb+srv://<username>:<password>@cluster0.mongodb.net/<dbname>?retryWrites=true&w=majority"
//        let client = try? MongoClient(connectionString)
//        let database = client?.db("demoApp")
//        let usersCollection = database?.collection("users")

        // Perform authentication using MongoDB Atlas as the database
//        let query: Document = ["email": email, "password": password]
        do {
//            let result = try usersCollection?.findOne(query)
            let result = 1
            if result == nil {
                completion(.failure(LoginError.userNotFound))
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

enum LoginError: Error {
    case emptyEmail
    case emptyPassword
    case userNotFound
}
