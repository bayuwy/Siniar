//
//  AudioExtensions.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 30/08/22.
//

import Foundation
import FeedKit

typealias Audio = RSSFeedItem
extension RSSFeedItem {
    var url: String? {
        return self.enclosure?.attributes?.url
    }
    
    var pictureUrl: String? {
        return self.iTunes?.iTunesImage?.attributes?.href
    }
}
