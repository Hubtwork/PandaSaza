//
//  SchoolValidation.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/04/11.
//

import SwiftUI

struct SchoolValidationView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) private var presentation
    
    @State private var schoolSearch: SchoolSearch = SchoolSearch()
    
    
    // MARK:- Phone Validation Info
    let phoneNumber: String
    
    var body: some View {
        content
            .foregroundColor(Color.black)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

extension SchoolValidationView {
    
    var content: some View {
        ZStack {
            
            self.schoolValidationView
                .padding(.top, 40)  // consider toolbar height
            
            self.signToolBar
            
            .navigationBarHidden(true)
        }
    }
    
    var schoolValidationView: AnyView {
        switch schoolSearch.filtered {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(loadingView(last))
        case let .loaded(schools): return AnyView(loadedView(schools))
        case let .failed(error): return AnyView(failedView(error))
        }
    }
    
    
    var signToolBar: some View {
        VStack(spacing: 0) {
            ZStack {
                self.toolBarTitle(title: "School Validation")
                
                self.toolBarButton
            }
            .padding(.vertical, 15)
            Spacer()
        }
    }
    
    var toolBarButton: some View {
        HStack{
            Button(action: {
                withAnimation {
                    presentation.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
    
    func toolBarTitle(title: String) -> some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(.custom("NanumGothicBold", size: 15))
            
            Spacer()
        }
    }
    
}

// MARK:- Loading Contents
private extension SchoolValidationView {
    var notRequestedView: some View {
        Text("").onAppear {
            self.loadSchools()
        }
    }
    
    func loadingView(_ previouslyLoaded: [School]?) -> some View {
        VStack {
            ActivityIndicatorView().padding()
            previouslyLoaded.map {
                loadedView($0)
            }
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.loadSchools()
        })
    }
}

// MARK:- Loaded Contents
private extension SchoolValidationView {
    func loadedView(_ schools: [School]) -> some View {
        VStack(spacing: 0){
            SearchBar(searchText: $schoolSearch.searchText,
                      hintText: "Search your school")
                .frame(height: 30)
            List(schools) { school in
                SchoolCell(school: school)
            }.padding(.leading, -15)
        }
        .padding(.top, 10)
        .padding(.horizontal, 30)
        .padding(.bottom, schoolSearch.keyboardHeight)
    }
}

// MARK:- Side Effect
private extension SchoolValidationView {
    
    func loadSchools() {
        injected.interactors.staticInteractor.getSchools(schools: $schoolSearch.allSchools)
    }
}

struct SchoolValidation_Previews: PreviewProvider {
    static var previews: some View {
        SchoolValidationView(phoneNumber: "01075187260")
            .inject(AppEnvironment.bootstrap().container)
    }
}
