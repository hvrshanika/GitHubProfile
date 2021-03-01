//
//  Apollo.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 3/1/21.
//

import Foundation
import Apollo

//ee341075d736dffc3965b0dda70985fe26ca560d

class Apollo {
    
    static let shared = Apollo()
    
    private(set) lazy var client: ApolloClient = {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = URL(string: "https://api.github.com/graphql")!
        
        
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url,
                                                                 additionalHeaders: ["Authorization": "Bearer ee341075d736dffc3965b0dda70985fe26ca560d"])
        
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }()
}

struct NetworkInterceptorProvider: InterceptorProvider {
    
    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
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
