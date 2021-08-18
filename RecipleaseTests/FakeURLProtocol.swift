//
//  FakeUrlProtocol.swift
//  RecipleaseTests
//
//  Created by Gilles Sagot on 11/08/2021.
//

import Foundation

final class FakeURLProtocol: URLProtocol {
    
    static var request: ((URLRequest) -> ( Data?, HTTPURLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let result = FakeURLProtocol.request else {
            return
        }
        let (data, response, _) = result(request)

        if let responseStrong = response {
            client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
        }
        if let dataStrong = data {
            client?.urlProtocol(self, didLoad: dataStrong)
        }
        else {
            class ProtocolError: Error {}
            let protocolError = ProtocolError()
            client?.urlProtocol(self, didFailWithError: protocolError)
        }

        client?.urlProtocolDidFinishLoading(self)
  
    }
    
    override func stopLoading() {
    }

}



/*
final class FakeURLProtocol: URLProtocol {
    
    enum ResponseType {
        case error(Error)
        case success(HTTPURLResponse)
    }
    static var responseType: ResponseType!
    
    private(set) var activeTask: URLSessionTask?
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    override func stopLoading() {
        activeTask?.cancel()
    }

}

extension FakeURLProtocol: URLSessionDataDelegate {
    
    enum MockError: Error {
        case none
    }
    
    static func responseWithFailure() {
        FakeURLProtocol.responseType = FakeURLProtocol.ResponseType.error(MockError.none)
    }
    
    static func responseWithStatusCode(code: Int) {
        FakeURLProtocol.responseType = FakeURLProtocol.ResponseType.success(HTTPURLResponse(url: URL(string: "http://any.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        switch FakeURLProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let response)?:
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        default:
            break
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
}
 */

