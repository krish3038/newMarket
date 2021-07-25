//
//  Utilities.swift
//  NewMarketServices
//
//  Created by RAMESH on 3/17/18.
//  Copyright © 2018 virtusa. All rights reserved.
//

import Foundation
import SystemConfiguration

class Utilities {
    static let DATE_FORMAT = "dd MMM yyyy"
    static let DATETIME_FORMAT = "dd MMM yyyy HH:mm"
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    static func createFolder(folderName : String) {
        let _: URL = {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectoryURL = urls[urls.count - 1] as URL
            let fileDirectoryURL = documentDirectoryURL.appendingPathComponent(folderName)
            
            if FileManager.default.fileExists(atPath: fileDirectoryURL.path) == false {
                do{
                    try FileManager.default.createDirectory(at: fileDirectoryURL, withIntermediateDirectories: false, attributes: nil)
                }catch{
                }
            }
            return fileDirectoryURL
        }()
    }
    
    static func createFile(foldername : String, fileName : String) -> String {
        createFolder(folderName: foldername)
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writePath = documents.appending("/\(foldername)/\(fileName).txt")
        return writePath
    }
    
    static func getListOfFilesFor(patient: String) -> [URL] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderURL = documentsURL.appendingPathComponent("\(patient)")
        var fileURLs = [URL]()
        do {
            fileURLs = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
      
        return fileURLs
    }
    
    static func removeFile(url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch  {
            print("Error removing files \(error)")
        }
    }
    
    static func getDateTimeFroml(timeStamp: TimeInterval, outformat: String) -> String {
        
        let dateTimeStamp = NSDate(timeIntervalSince1970:timeStamp/1000)
        
        let formatter = DateFormatter()
        formatter.dateFormat = outformat
        
        //Using the dateFromString variable from before.
        let stringDate: String = formatter.string(from: dateTimeStamp as Date)
        
        return stringDate
    }
    
    class  func isNetworkNotReachable() ->Bool {
        let reachable = Reachability.forInternetConnection()
        let status = reachable?.currentReachabilityStatus()
        return status == NotReachable
    }
}

