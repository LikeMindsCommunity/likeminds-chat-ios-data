struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = ServiceConfiguration.authBaseURL
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
