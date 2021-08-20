//
//  SourcesData+CoreDataClass.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/08/21.
//
//

import Foundation
import CoreData

@objc(SourcesData)
public class SourcesData: NSManagedObject, Decodable {
    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

        self.init(context: context)
}
}

