//
//  UseCloudyLogs.swift
//  HowToSwift
//
//  Created by Moi Gutierrez on 9/2/21.
//

import SwiftUI
import CloudyLogs
import SwiftUIComponents

struct UseCloudyLogs: View {
    
    @State var logCount = 0
    
    var body: some View {
        VStack {
            
            Button("create new log") {
                Logger.log("\(logCount) log to console and text file")
            }
            .padding()
            
            Button("clear logs") {
                Logger.clearLogFile()
            }
            .padding()
            
            Button("remove first line") {
                Logger.removeFirstLine()
            }
            .padding()
            
        }
    }
}

struct UseCloudyLogs_Previews: PreviewProvider {
    static var previews: some View {
        UseCloudyLogs()
    }
}
