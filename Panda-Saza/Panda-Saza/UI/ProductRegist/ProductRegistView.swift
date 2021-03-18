//
//  ProductRegistView.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/01.
//

import SwiftUI
import Combine

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct ProductRegistView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var itemName: String = ""
    @State var itemCategory: String = "카테고리 선택"
    
    @ObservedObject var itemPrice = NumbersOnly()
    @State var canNegotiate: Bool = false
    /// Image Picker Relative
    @State var showImagePicker = false
    @State var selectedImage: [ProductItemImage] = []
    
    @State private var itemContents: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                self.topTitleBar
                Divider()
                    .background(Color.black)
                ScrollView {
                    
                    self.photoView
                    Divider()
                    /// item Name
                    self.itemNameView
                    Divider()
                    self.itemCategoryView
                    Divider()
                    self.itemPriceView
                    Divider()
                    self.itemContentsView
                    
                }.padding(.horizontal, 15)
                .padding(.top, 10)
            }
            
            .navigationBarHidden(true)
        }
        .onReceive(PSImagePicker.shared.$images, perform: { images in self.selectedImage = images
        })
        .sheet(isPresented: self.$showImagePicker, content: {
            PSImagePicker.shared.view
        })
    }
}

extension ProductRegistView {
    
    var photoView: some View {
        HStack(alignment: .center) {
            Button(action: {
                showImagePicker = true
            }) {
                VStack(spacing: 5) {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    Text(String(selectedImage.count) + " / 10")
                        .font(.body)
                }
                .frame(width: 80, height: 80)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }.foregroundColor(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5){
                    ForEach(self.selectedImage, id: \.id) { item in
                        Image(uiImage: item.photo!)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                    }
                }
                .padding(10)
            }
            
        }.padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
    
    var itemNameView: some View {
        HStack {
            TextField("상품 제목", text: $itemName)
                .font(.body)
        }.padding(.vertical, 10)
    }
    
    var itemCategoryView: some View {
        NavigationLink(destination: CategoryView(viewModel: CategoryViewModel(), text: $itemCategory).navigationBarHidden(true).foregroundColor(.black)) {
            HStack {
                Text(itemCategory)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.black)
            }.padding(.vertical, 10)
        }
    }
    
    var itemPriceView: some View {
        HStack(spacing: 10) {
            /// Toggle Currency String
            if self.itemPrice.value.isEmpty {
                Text("₩")
                    .foregroundColor(.gray)
                    .font(.body)
            }
            else {
                Text("₩")
                    .foregroundColor(.black)
                    .font(.body)
            }
            /// Toggle Price
            TextField("희망 가격", text: $itemPrice.value)
                .font(.body)
                .keyboardType(.decimalPad)
            Spacer()
            /// Toggle Negotiate
            HStack{
                Button(action: { self.canNegotiate.toggle() } )
                {
                    if self.canNegotiate == false {
                        Image(systemName: "chevron.down.circle")
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "chevron.down.circle")
                            .foregroundColor(.red)
                    }
                    
                }
                Text("가격 제시")
                    .font(.body)
            }
        }.padding(.vertical, 10)
    }
    
    var itemContentsView: some View {
        VStack {
            TextField("물품에 대한 상세한 정보를 적어주세요, 상대방의 이해를 돕고 구매욕구를 증진시킬 수 있습니다.", text: $itemContents)
                .font(.body)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
        }
            
    }
    
    var topTitleBar: some View {
        ZStack {
            HStack {
                
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Text("닫기")
                        .font(.title2)
                }.foregroundColor(.black)
                Spacer()
                Button(action: { presentation.wrappedValue.dismiss() }) {
                    Text("완료")
                        .font(.title2)
                }.foregroundColor(.black)
            }.padding(.vertical, 10)
            .padding(.horizontal, 10)
            HStack {
                Spacer()
                Text("상품 판매")
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.vertical, 10)
        }
    }
}

struct ProductRegistView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRegistView()
    }
}
