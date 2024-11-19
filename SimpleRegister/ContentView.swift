//
//  ContentView.swift
//  FirebaseProject
//
//  Created by Choyan on 14/11/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    var body: some View {
        if userIsLoggedIn{
            ListView()
         }else{
            content
        }
        content
    }
    var content: some View{
        ZStack{
            Color.black
            RoundedRectangle(cornerRadius: 30, style: .continuous).foregroundStyle(.linearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 1000, height: 400).rotationEffect(.degrees(35)).offset(y:-350)
            VStack(spacing: 20){
                
                    Text("Welcome").foregroundColor(.red).font(.system(size: 40,weight: .bold,design: .rounded)).offset(x:0,y:-100)
                TextField("Email:",text:$email).foregroundColor(.white).textFieldStyle(.plain).placeholder(when: email.isEmpty){
                    Text("Email").foregroundColor(.white).bold()
                }
                Rectangle().frame(width: 350, height: 1).foregroundColor(.white)
                SecureField("Password", text: $password)
                    .foregroundColor(.white).textFieldStyle(.plain).placeholder(when: password.isEmpty){
                        Text("Password").foregroundColor(.white).bold()
                    }
                
                Rectangle().frame(width: 350, height: 1).foregroundColor(.white)
                Button{
                    register()
                }label: {
                    Text("Sign Up").bold().frame(width: 200, height:40).background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors:[.green, .blue],startPoint: .top, endPoint: .bottomTrailing))).foregroundColor(.white)
                }
                .padding(.top).offset(y:100)
                Button {
                    login()
                }label: {
                    Text("Already have an Account? Login").bold().foregroundColor(.white)
                }.padding(.top).offset(y:100)
            }.frame(width: 350)
                .onAppear{
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            userIsLoggedIn.toggle()
                        }
                    }
                }
        }.ignoresSafeArea()
    }
    func login(){
        
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    func register(){
        
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View{
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder:()->Content) ->some View{
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 :0)
                self
            }
            
        }
}
