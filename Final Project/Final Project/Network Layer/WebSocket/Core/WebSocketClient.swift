//
//  WebSocketClient.swift
//  Final Project
//
//  Created by SabinaKarimli on 13.02.26.
//


import Foundation

protocol WebSocketClient {
    func textStream(url: URL, headers: [String:String]?) -> AsyncThrowingStream<String, Error>
    func close() 
}
