//
//  PageModel.swift
//  Collaboration3_iBanProject
//
//  Created by IT Academy - 5  on 12.01.24.
//

import Foundation
import SwiftUI

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var image: Image
    var description: [String]
    var tag: Int
    
    static var samplePage = Page(name: "Title", image: Image.onboardingFirstScreenImage, description: ["Hiiiiiiii", "whatup"], tag: 0)
    
    static let onboardPages: [Page] = [
        Page(name: "Welcome to iGuard", image: Image.onboardingFirstScreenImage, description: ["", "", ""], tag: 0),
        Page(name: "Storage Benefits", image: Image.onboardingSecondScreenImage, description: ["Encrypt and secure your IBans", "Effortlessly orginize your banking details", "Bank securly with advanced features"], tag: 1),
        Page(name: "Easy Managment", image: Image.onboardingThirdScreenImage, description: ["Seamless control of your IBans", "Effortlesly handle your banking data", "Simplified IBan organization for you"], tag: 2)
    ]
}
