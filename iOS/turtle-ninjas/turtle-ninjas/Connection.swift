//
//  Connection.swift
//  turtle-ninjas
//
//  Created by Vitor Oliveira on 5/21/16.
//  Copyright © 2016 Vitor Oliveira. All rights reserved.
//

import SystemConfiguration

public class Connection {
    
    class func isON() -> Bool {
    
        var zAddress = sockaddr_in()
        var reachabilityFlags = SCNetworkReachabilityFlags()
        
        zAddress.sin_len = UInt8(sizeofValue(zAddress))
        zAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRoute = withUnsafePointer(&zAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        
        if !SCNetworkReachabilityGetFlags(defaultRoute!, &reachabilityFlags) {
            return false
        }
        
        let isReachable = (reachabilityFlags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (reachabilityFlags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    
    }
    
}