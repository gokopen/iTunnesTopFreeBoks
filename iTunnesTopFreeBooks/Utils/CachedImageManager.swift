//
//  CachedImageManager.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class CachedImageManager {
    
    static let shared = CachedImageManager()
    
    private var existingItems: [String: URL] = [:]
    private var currentlyDownlading: [String] = []
    private let api = Api()
    
    func setImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let secureUrl = URL(string: url) {
            if currentlyDownlading.contains(url) == false {
                if let existingImageLocalFileURL = existingItems[url] {
                    let image = self.getFromLocalFile(url: existingImageLocalFileURL)
                    DispatchQueue.main.async { [weak self, completion] in
                        if self != nil {
                            completion(image)
                        }
                    }
                } else {
                    currentlyDownlading.append(url)
                    api.download(url: secureUrl) { [weak self] (success, localTempFileUrl) in
                        guard let self = self else { return }
                        if let index = self.currentlyDownlading.firstIndex(of: url), index < self.currentlyDownlading.count {
                            self.currentlyDownlading.remove(at: index)
                        }
                        if let secureLocalTempURL = localTempFileUrl {
                            
                            let allDocumentsUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                            var documentsPath = allDocumentsUrls.first?.path ?? ""
                            let last = secureLocalTempURL.lastPathComponent
                            documentsPath.append(last)
                            
                            var refURL = secureLocalTempURL
                            let documentsUrl = URL(fileURLWithPath: documentsPath)
                            do {
                                try FileManager.default.copyItem(at: secureLocalTempURL, to: documentsUrl)
                                refURL = documentsUrl
                            } catch {
                                print("Error occured when copying the files to the user documents! error: \(error.localizedDescription)")
                            }
            
                            let image = self.getFromLocalFile(url: refURL)
                            DispatchQueue.main.async { [weak self, completion] in
                                if self != nil {
                                    completion(image)
                                }
                            }
                        }
                        
                    }
                }
            }
        } else {
            print("CachedImageManager detect not vailid url: \(url) - So this item not needs to be processed!")
        }
        
    }
    
    private func getFromLocalFile(url: URL) -> UIImage? {
        let image = UIImage(contentsOfFile: url.path)
        if image == nil {
            print("Something wrong when trying to get the image from disk: \(url.absoluteString)")
        }
        return image
    }
    
}
