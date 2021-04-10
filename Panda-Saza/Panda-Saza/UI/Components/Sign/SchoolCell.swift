//
//  SchoolCell.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/10.
//

import SwiftUI

struct SchoolCell: View {
    
    let school: School
    @Environment(\.locale) var locale: Locale
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(school.name.localized(locale))
                .font(.custom("NanumGothic", size: 25))
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
    }
}

struct SchoolCell_Previews: PreviewProvider {
    static var previews: some View {
        SchoolCell(school: School(sId: 1, name: "Dongguk University"))
            .previewLayout(.fixed(width: UIScreen.screenWidth, height: 60))
    }
}
