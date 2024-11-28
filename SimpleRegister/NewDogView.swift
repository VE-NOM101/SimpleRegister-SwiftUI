import SwiftUI

struct NewDogView: View {
    @EnvironmentObject var dataManager: DataManager
    @State var newDog: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Add New Dog")

            // Text Field
            TextField("Enter dog breed...", text: $newDog)

            // Save Button
            Button(action: {
                dataManager.addDog(dogBreed: newDog)
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct NewDogView_Previews: PreviewProvider {
    static var previews: some View {
        NewDogView().environmentObject(DataManager())
    }
}
