//
//  Test.swift
//  Panda-Saza
//
//  Created by Jae Heo on 2021/02/26.
//

import Foundation
import Combine
import SwiftUI


struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

enum TestDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://reqres.in/api/users/")!
}

// 2
enum APIPath: String {
    case userId = "2"
}

extension TestDB {
    
    static func request(_ path: APIPath) -> AnyPublisher<TestResponse, Error> {
        // 3
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}

struct TestResponse: Codable {
    let data: [TestDTO]

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct TestDTO: Codable, Identifiable {
    var id = UUID()
    let dataId: Int
    let dataEmail: String
    let dataFirstName: String
    let dataLastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case dataId = "id"
        case dataEmail = "email"
        case dataFirstName = "first_name"
        case dataLastName = "last_name"
        case avatar = "avatar"
    }
}

class TestViewModel: ObservableObject {
    
    @Published var data: [TestDTO] = [] // 1
    var cancellationToken: AnyCancellable? // 2
    
    init() {
        getMovies() // 3
    }
    
}

extension TestViewModel {
    
    // Subscriber implementation
    func getMovies() {
        cancellationToken = TestDB.request(.userId) // 4
            .mapError({ (error) -> Error in // 5
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, // 6
                  receiveValue: {
                    self.data = $0.data // 7
            })
    }
    
}

struct MoviesView: View {
    
    // 1
    @ObservedObject var viewModel = TestViewModel()
    
    var body: some View {
        List(viewModel.data) { data in // 2
            HStack {
                VStack(alignment: .leading) {
                    Text(String(data.dataId)) // 3a
                        .font(.headline)
                    Text(data.dataEmail) // 3b
                        .font(.subheadline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MoviesView()
    }
}
