//
//  Sound.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 5/3/23.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
public class Sound: NSManagedObject, Codable{

    enum CodingKeys: CodingKey {
        case file, name
    }
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.file = try container.decode(String.self, forKey: .file)
        self.name = try container.decode(String.self, forKey: .name)
//        self.completions = try container.decode(Set<Sound>.self, forKey: .completions) as NSSet
    }
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(file, forKey: .file)
        try container.encode(name, forKey: .name)
      //try container.encode(completions as! Set<ToddoCompletion>, forKey: .completions)
    }
}
extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
