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

struct ContactFormView:View {
    
  @State  var name = ""
    @State  var sectionType = SectionType.ceo

    var didAddContact:(String,SectionType)-> () = {_,_ in}
    var didCancelContact:()-> () = { }

    
    var body:some View{
        VStack {
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
        }.padding()
    }
    
}

//struct ContentView_Previewss: PreviewProvider {
//    static var previews: some View {
//        ContactFormView()
//    }
//}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
