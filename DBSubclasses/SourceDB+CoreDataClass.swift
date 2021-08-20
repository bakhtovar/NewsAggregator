//
//  SourceDB+CoreDataClass.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/08/21.
//
//

import Foundation
import CoreData

@objc(SourceDB)
public class SourceDB: NSManagedObject, Decodable {
    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

        self.init(context: context)
    }
}
