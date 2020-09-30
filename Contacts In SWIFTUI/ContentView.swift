//
//  ContentView.swift
//  Contacts In SWIFTUI
//
//  Created by Hossam on 9/29/20.
//

import SwiftUI







struct ContactRowView:View {
    
    @ObservedObject var vm = ContactViewModel()
    
    var body:some View{
        HStack{
            Image(systemName: "person.fill")
                .font(.system(size: 34))
            Text(vm.name)
                
            Spacer()
            Image(systemName:vm.isFavorite ? "star.fill"  : "star")
                .font(.system(size: 24))
        }.padding(20)
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
   
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePicker
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()

        }

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }

}

struct ContactFormView:View {
    
  @State  var name = ""
    @State  var sectionType = SectionType.ceo
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image : Image? = Image(systemName: "person.circle")

    var didAddContact:(String,SectionType)-> () = {_,_ in}
    var didCancelContact:()-> () = { }

    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body:some View{
        VStack {
            
            HStack{
                Spacer()
                VStack{
                    image?
                        .resizable()
                        .clipShape(Circle())
                        .font(.system(size: 10))
                        
                        .onTapGesture(count: 1, perform: {
                            self.showingImagePicker = true
                            
                        })
                }.padding(.bottom,16)
                Spacer()
            }.padding()
            
            TextField("name", text: $name)
            Picker( selection: $sectionType,label:Text("ABC")) {
                Text("CEO").tag(SectionType.ceo)
                Text("Passants").tag(SectionType.passants)
            }.pickerStyle(SegmentedPickerStyle())
        Button(action: {
            self.didAddContact(name,sectionType)
        }, label: {
            HStack {
                Spacer()
                Text("Add").foregroundColor(Color.white)
                Spacer()
            }.padding().background(Color.blue)
            .cornerRadius(5)
        })
        
            Button(action: {
                self.didCancelContact()
            }, label: {
                HStack {
                    Spacer()
                    Text("Cancel").foregroundColor(Color.white)
                    Spacer()
                }.padding().background(Color.red)
                .cornerRadius(5)
            })
        Spacer()
            Spacer()
        }.padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
}

struct ContentView_Previewss: PreviewProvider {
    static var previews: some View {
        ContactFormView()
    }
}

struct DiffableContainer:UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return UINavigationController(rootViewController: DiffableTableViewVC(style: .insetGrouped))
    }
}

struct ContentView: View {
    var body: some View {
        DiffableContainer()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
