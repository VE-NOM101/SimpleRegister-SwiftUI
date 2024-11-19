//
//  SimpleRegisterApp.swift
//  SimpleRegister
//
//  Created by Tanmoy Biswas on 15/11/24.
//

import SwiftUI
import Firebase
@main
struct SimpleRegisterApp: App {
    @StateObject var dataManager = DataManager()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ListView().environmentObject(dataManager)
        }
    }
}
