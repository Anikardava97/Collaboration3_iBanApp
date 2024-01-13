//
//  LogoImage.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct LogoImage: View {
    //MARK: - Body
    var body: some View {
        Image.logoWithTitle
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .padding(.bottom, 60)
    }
}
//TODO: REMOVE COMMENT
//#Preview {
//    LogoImage()
//}
