//
//  ProductsDetail.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/29.
//

import SwiftUI
import Combine

struct ProductsDetailRoutedView: View {
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var productDetail: Loadable<ProductDetails>
    
    @State var imageIndex = 0
    
    @State private var loadedStatus = LoadedStatus()

    let fontName: String = "NanumGothic-Regular"
    let itemId: Int
    
    init(itemId: Int, product: Loadable<ProductDetails> = .notRequested) {
        self.itemId = itemId
        self._productDetail = .init(initialValue: product)
    }
    
    var body: some View {
        self.content
            .navigationBarHidden(true)
            /**
            .onReceive(productDetailsFetch) {
                self.loadedStatus.fetchedProduct = $0
            }
         */
    }
}


extension ProductsDetailRoutedView {
    private var content: AnyView {
        switch productDetail {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(loadingView(last))
        case let .loaded(productDetail): return AnyView(loadedView(productDetail))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
}

// MARK: - Loading Content

private extension ProductsDetailRoutedView {
    var notRequestedView: some View {
        VStack{
            Text("Not Yet")
        }.onAppear {
            self.loadProductDetail()
            //self.loadProduct(itemId: self.itemId)
        }
    }
    
    func loadingView(_ previouslyLoaded: ProductDetails?) -> some View {
        VStack {
            ActivityIndicatorView().padding()
            previouslyLoaded.map {
                loadedView($0)
            }
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.loadProductDetail()
            //self.loadProduct(itemId: self.itemId)
        })
    }
}

// MARK: - Displaying Content

private extension ProductsDetailRoutedView {
    
    func loadedView(_ product: ProductDetails) -> some View {
        ScrollView {
            VStack(spacing: 0){
                ProductImageContainer(imageUrlStrings: product.itemImages)
                SellerProfileCell(profileImageUrlString: product.sellerProfileIcon, userName: product.sellerName, userLocale: product.sellerLocale, schoolName: product.sellerSchool, rating: product.sellerRating)
                
                Divider()
                    .padding(.horizontal, 10)
                
                ProductContentCell(itemName: product.itemTitle, itemCategory: product.itemCategory, itemRegistrationTime: product.registrationTime, itemContents: product.itemContents, chatCount: product.cnt_chat, likeCount: product.cnt_like, viewCount: product.cnt_show)
            }
        }
    }
    
}

// MARK: - Side Effects

private extension ProductsDetailRoutedView {
    
    func loadProductDetail() {
        injected.interactors.productsInteractor.loadProductDetail(product: $productDetail, productId: itemId)
    }
    
    func loadProduct(itemId: Int) {
        injected.interactors.productsInteractor.load(productId: self.itemId)
    }
}

// MARK: - Loaded State Manager

private extension ProductsDetailRoutedView {
    struct LoadedStatus {
        private(set) var product: Loadable<ProductDetails> = .notRequested
        var fetchedProduct: Loadable<ProductDetails> = .notRequested {
            didSet { product = fetchedProduct }
        }
    }
}

// MARK: - State Updates
private extension ProductsDetailRoutedView {
    
    var productDetailsFetch: AnyPublisher<Loadable<ProductDetails>, Never> {
        injected.appState.updates(for: \.loadedData.productDetails)
    }
    
}

// MARK: - Preview

#if DEBUG
struct ProductsDetailRoutedView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsDetailRoutedView(itemId: 1).inject(AppEnvironment.bootstrap().container)
    }
}
#endif
