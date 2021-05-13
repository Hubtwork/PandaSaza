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
                .font(.custom("NanumGothic", size: 15))
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SchoolCell_Previews: PreviewProvider {
    static var previews: some View {
        SchoolCell(school: School(sId: 1, name: "Dongguk University"))
            .previewLayout(.fixed(width: UIScreen.screenWidth, height: 100))
    }
}
