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
    
    @State private var queue = DispatchQueue(label: "my queue")
    
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
            
            HStack {
                
                VStack {
                    Button("create") {
                        create()
                    }
                    .foregroundColor(Color.green)
                    
                    Divider()
                    
                    Button("clear") {
                        clear()
                    }
                    .foregroundColor(Color.green)
                }
                .padding()
                
                Divider()
                
                VStack {
                    
                    Button("save") {
                        save()
                    }
                    Divider()
                    
                    Button("update") {
                        update()
                    }
                    Divider()
                    
                    Button("read") {
                        read()
                    }
                }
                .padding()
                
                Divider()
                
                Button("delete") {
                    delete()
                }
                .foregroundColor(Color.red)
                
            }
            .fixedSize(horizontal: false, vertical: true)
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
            
        }
    }
    
    func create() {
        queue.async {
            parent = Parent(child: Child(child: ChildChild()))
        }
    }
    
    func clear() {
        queue.async {
            parent = nil
            
        }
    }
    
    func save() {
        queue.async {
            Defaults[\.parent] = parent
        }
    }
    
    func read() {
        queue.async {
            parent = Defaults[\.parent]
        }
    }
    
    func update() {
        queue.async {
            parent = Parent(child: Child(child: ChildChild()))
        }
    }
    
    func delete() {
        queue.async {
            parent = nil
            Defaults[\.parent] = parent
        }
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
        // TODO: fix: Thread 16: Simultaneous accesses to 0x1089b99e0, but modification requires exclusive access
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
