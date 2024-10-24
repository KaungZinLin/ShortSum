//
//  ScanData.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 14/06/2024.
//

import Foundation


struct ScanData:Identifiable {
    var id = UUID()
    let content:String
    
    init(content:String) {
        self.content = content
    }
}
