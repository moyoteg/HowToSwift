//
//  UseSwiftyUserDefaults.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 2/22/21.
//

import SwiftUI
import SwiftyUserDefaults

struct UseSwiftyUserDefaults: View {
    
    @State var parent: Parent?
    
    var body: some View {
        VStack {
            Toggle("use default value for reading Parent", isOn: Binding<Bool>(
                    get: { () -> Bool in
                        Defaults[\.useDefault]
            }, set: { (value) in
                Defaults[\.useDefault] = value
            }))
                .padding()
            
            Divider()
            
            Text("Parent > Child > ChildChild")
                .padding()
            
            Divider()
            
            if parent == nil {
                Text("parent is nil")
                    .padding()
            } else {
                VStack {
                    Text("parent: \n\(parent!.id)")
                    Text("child: \n\(parent!.child.id)")
                    Text("child child: \n\(parent!.child.child.id)")
                }
                .padding()
            }
        }
        .toolbar {
            HStack {
                Button("create") {
                    create()
                }
                .foregroundColor(Color.green)
                
                Button("clear") {
                    clear()
                }
                .foregroundColor(Color.green)
                
                Divider()

                Button("save") {
                    save()
                }
                
                Button("update") {
                    update()
                }
                
                Button("read") {
                    read()
                }
                
                Divider()
                
                Button("delete") {
                    delete()
                }
                .foregroundColor(Color.red)
                
            }
        }
    }
    
    func create() {
        parent = Parent(child: Child(child: ChildChild()))
    }

    func clear() {
        parent = nil
    }
    
    func save() {
        Defaults[\.parent] = parent
    }
    
    func read() {
        parent = Defaults[\.parent]
    }
    
    func update() {
        parent = Parent(child: Child(child: ChildChild()))
    }
    
    func delete() {
        parent = nil
        Defaults[\.parent] = parent
    }
}


// - Models

// Parent > Child > ChildChild

class Parent: Codable, DefaultsSerializable {
    
    var child: Child
    var id = UUID()
    
    init(child: Child) {
        self.child = child
    }
}

class Child: Codable, DefaultsSerializable {
    
    var child: ChildChild
    var id = UUID()
    
    init(child: ChildChild) {
        self.child = child
    }
}

class ChildChild: Codable, DefaultsSerializable {
    var id = UUID()
}

extension DefaultsKeys {
    var parent: DefaultsKey<Parent?> {
        if Defaults[\.useDefault] {
            return DefaultsKey<Parent?>.init("parent", defaultValue: `default`())
        } else {
            return DefaultsKey<Parent?>.init("parent")
        }
    }
    
    var useDefault: DefaultsKey<Bool> { .init("useDefault", defaultValue: false) }

}


func `default`() -> Parent {
    Parent(child: Child(child: ChildChild()))
}
