//
//  ListView.swift
//  SimpleRegister
//
//  Created by Tanmoy Biswas on 15/11/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false
    var body: some View {
        NavigationView{
            List(dataManager.dogs, id: \.id){ dog in
                Text(dog.breed)
            }.navigationTitle("Dogs")
                .navigationBarItems(trailing: Button(action: {
                    //add
                    showPopup.toggle()
                }, label:{
                    Image(systemName: "plus")
                })).navigationBarItems(trailing: Button(action: {
                    //add
                    logout()
                }, label:{
                    Text("Logout")
                })).sheet(isPresented: $showPopup){
                    NewDogView()
                }
            
        }
    }
    func logout() {
        do {
            try Auth.auth().signOut()
            print("User logged out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}

struct ListView_Previews: PreviewProvider{
    static var previews: some View{
        ListView().environmentObject(DataManager())
    }
}
