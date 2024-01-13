//
//  PageView.swift
//  Collaboration3_iBanProject
//
//  Created by IT Academy - 5  on 12.01.24.
//

import SwiftUI

struct PageView: View {
    //MARK: - Properties
    var page: Page
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 30) {
            onboardImage
            titleText
            descriptionStack
        }
        .padding(30)
    }
}

//MARK: - Content
extension PageView {
    private var onboardImage: some View {
        page.image
            .resizable()
            .scaledToFit()
            .padding()
            .frame(width: 250, height: 250)
    }
    
    private var titleText: some View {
        Text(page.name)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
    
    private var descriptionStack: some View {
        VStack(alignment: .leading, spacing: 25){
            ForEach(page.description.indices, id: \.self) { index in
                DescriptionText(text: page.description[index])
            }
        }
    }
    
    struct DescriptionText:  View {
        var text: String
        
        var body: some View {
            if !text.isEmpty {
                HStack {
                    Checkmark()
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }
            } else {
                HStack {
                    Checkmark()
                        .hidden()
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }
            }
        }
    }
    
    struct Checkmark: View {
        var body: some View {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.customAccentColor)
        }
    }
}

//MARK: - Preview
struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage)
            .background(Color.customBackgroundColor)
    }
}
