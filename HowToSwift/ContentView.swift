//
//  ContentView.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 2/22/21.
//

import SwiftUI
import SwiftUIComponents
import CoreData

let howTos: [HowTo] = [
    HowTo(isResolved: true, " 🔬 👨‍💻 sandbox 👩‍💻 🧪", AnyView(SandBox())),
    HowTo(isResolved: false, "use swifty user defaults", AnyView(UseSwiftyUserDefaults())),
    HowTo(isResolved: true, "use core data", AnyView(UserCoreData())),

]

struct ContentView: View {

    
    var body: some View {
        VStack {
            NavigationView {
                FilteredList("How To",
                             list: howTos) { (howTo) in
                    NavigationLink(howTo.description,
                                   destination:
                                    howTo.view
                                    .navigationBarTitle("\(howTo.name)")
                    )
                }
            }
            .shadow(radius: 10)
            Divider()
            HStack {
                Text("✅ resolved")
                Divider()
                Text("❌ unresolved")
            }
            .fixedSize()
            Divider()
            VStack {
                Text("by ") +
                    Text("Moi Gutiérrez")
                    .font(.system(size: 18, weight: .bold, design: .default)) +
                    Text(" with ❤️")
                Link("@moyoteg",
                     destination: URL(string: "https://www.twitter.com/moyoteg")!)
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
