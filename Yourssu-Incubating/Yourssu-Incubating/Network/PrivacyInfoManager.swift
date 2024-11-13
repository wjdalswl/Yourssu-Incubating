//
//  PrivacyInfoManager.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation

enum PrivacyInfoKeys {
    static let baseURL = "BaseURL"
}

final class PrivacyInfoManager {
    
    static let shared = PrivacyInfoManager()
    
    class var baseURL: String {
        guard let url = shared.info[PrivacyInfoKeys.baseURL] else { fatalError("BaseURL: Base-Info Plist error")}
        return url
    }
    
    private var info: [String: String] {
        guard let plistPath = Bundle.main.path(forResource: "PrivacyInfo", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: plistPath) as? [String: String] else {
            return [:]
        }
        return plist
    }
}
