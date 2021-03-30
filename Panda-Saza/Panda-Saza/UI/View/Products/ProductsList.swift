//
//  ProductList.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/03/28.
//

import SwiftUI
import Combine

struct ProductList: View {
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    let fontName: String = "NanumGothic-Regular"
    
    //  UI Values
    var cellWidth: CGFloat = UIScreen.screenWidth * 0.47
    var cellSpace: CGFloat = UIScreen.screenWidth * 0.03
    
    @State private var loadedStatus = LoadedStatus()
    
    var body: some View {
        self.content
            .onReceive(productsUpdate) { self.loadedStatus.allProducts = $0 }
    }
    
}


extension ProductList {
    private var content: AnyView {
        switch loadedStatus.products {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(loadingView(last))
        case let .loaded(products): return AnyView(loadedView(products))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
}

// MARK: - Check for Authentication / SignIn

extension ProductList {
    private var loginNoticeView: some View {
        VStack(alignment: .leading) {
            Text("Sign In is required to use the trading function")
                .font(.custom(fontName, size: 15))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(Color.orange.opacity(0.9))
    }
    
    private var authNoticeView: some View {
        VStack(alignment: .leading) {
            Text("User authentication is required to use the trading function")
                .font(.custom(fontName, size: 15))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(Color.orange.opacity(0.9))
    }
}

// MARK: - Loaded State Manager

private extension ProductList {
    struct LoadedStatus {
        private(set) var products: Loadable<[Product]> = .notRequested
        var allProducts: Loadable<[Product]> = .notRequested {
            didSet { loadedMoreProducts() }
        }
        var loadedCount: Int = 0
        
        private mutating func loadedMoreProducts() {
            products = allProducts
        }
    }
}


// MARK: - Side Effects

private extension ProductList {
    func loadProducts() {
        injected.interactors.productsInteractor.loadProducts()
    }
}

// MARK: - Loading Content

private extension ProductList {
    var notRequestedView: some View {
        Text("").onAppear {
            self.loadProducts()
        }
    }
    
    func loadingView(_ previouslyLoaded: [Product]?) -> some View {
        VStack {
            ActivityIndicatorView().padding()
            previouslyLoaded.map {
                loadedView($0)
            }
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.loadProducts()
        })
    }
}

// MARK: - Displaying Content

private extension ProductList {
    func loadedView(_ products: [Product]) -> some View {
        NavigationView {
            VStack(spacing: 0){
                if injected.appState[\.system].isLogin == false {
                    self.loginNoticeView
                } else if injected.appState[\.system].isAuth == false {
                    self.authNoticeView
                }
                ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed(cellWidth), spacing: cellSpace),
                    GridItem(.fixed(cellWidth))
                ], alignment: .center, spacing: cellSpace, content: {
                    ForEach(products, id: \.self) { product in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: self.detailsView(productId: product.itemId) ){
                                ProductCell(product: product, cellWidth: cellWidth)
                            }
                        }
                    }
                })
                .padding(.vertical, cellSpace)
                }
            }
            
            .navigationBarHidden(true)
        }
    }
    
    func detailsView(productId: Int) -> some View {
        ProductsDetailRoutedView(itemId: productId)
    }
}

// MARK: - Routing
extension ProductList {
    struct Routing: Equatable {
        
    }
}

// MARK: - State Updates
private extension ProductList {
    
    var productsUpdate: AnyPublisher<Loadable<[Product]>, Never> {
        injected.appState.updates(for: \.loadedData.products)
    }
    
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList().inject(AppEnvironment.bootstrap().container)
    }
}
