//
//  Apollo.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 3/1/21.
//

import Foundation
import Apollo

enum Constants {
    static let pat: [UInt8] = [118, 69, 21, 32, 82, 10, 80, 83, 83, 64, 84, 127, 50, 126, 86, 12, 85, 85, 77, 118, 22, 65, 119, 86, 13, 81, 84, 4, 17, 7, 124, 53, 41, 6, 83, 6, 6, 71, 114, 18]
}

class Apollo {
    
    static let shared = Apollo()
    
    private(set) lazy var client: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = URL(string: "https://api.github.com/graphql")!
        
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url,
                                                                 additionalHeaders: ["Authorization": "Bearer \(Obfuscator().reveal(key: Constants.pat))"])
        
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }()
}

struct NetworkInterceptorProvider: InterceptorProvider {
    private let store: ApolloStore
    private let client: URLSessionClient
    
    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }
    
    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            LegacyCacheReadInterceptor(store: self.store),
            NetworkFetchInterceptor(client: self.client),
            ResponseCodeInterceptor(),
            LegacyParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            LegacyCacheWriteInterceptor(store: self.store)
        ]
    }
}
