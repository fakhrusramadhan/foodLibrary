//
//  FoodModel.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 03/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let food = try Food(json)

import Foundation

typealias Hits = [Hit]

class Food: Codable {
    let q: String
    let from, to: Int
    let params: Params
    let more: Bool
    let count: Int
    let hits: [Hit]
    
    init(q: String, from: Int, to: Int, params: Params, more: Bool, count: Int, hits: [Hit]) {
        self.q = q
        self.from = from
        self.to = to
        self.params = params
        self.more = more
        self.count = count
        self.hits = hits
    }
}

class Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
    
    init(recipe: Recipe, bookmarked: Bool, bought: Bool) {
        self.recipe = recipe
        self.bookmarked = bookmarked
        self.bought = bought
    }
}

class Recipe: Codable {
    let uri, label, image, source: String
    let url, shareAs: String
    let yield: Int
//    let dietLabels: [DietLabel]
    let dietLabels: [String]
//    let healthLabels: [HealthLabel]
    let healthLabels: [String]
    let cautions: [JSONAny]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
    let digest: [Digest]
    
    init(uri: String, label: String, image: String, source: String, url: String, shareAs: String, yield: Int, dietLabels: [String], healthLabels: [String], cautions: [JSONAny], ingredientLines: [String], ingredients: [Ingredient], calories: Double, totalWeight: Double, totalTime: Int, totalNutrients: [String: Total], totalDaily: [String: Total], digest: [Digest]) {
        self.uri = uri
        self.label = label
        self.image = image
        self.source = source
        self.url = url
        self.shareAs = shareAs
        self.yield = yield
        self.dietLabels = dietLabels
        self.healthLabels = healthLabels
        self.cautions = cautions
        self.ingredientLines = ingredientLines
        self.ingredients = ingredients
        self.calories = calories
        self.totalWeight = totalWeight
        self.totalTime = totalTime
        self.totalNutrients = totalNutrients
        self.totalDaily = totalDaily
        self.digest = digest
    }
}

enum DietLabel: String, Codable {
    case highProtein = "High-Protein"
    case lowCarb = "Low-Carb"
}

class Digest: Codable {
    let label, tag: String
//    let schemaOrgTag: SchemaOrgTag?
    let schemaOrgTag: String?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: SubUnit
    let sub: [Digest]?
    
    init(label: String, tag: String, schemaOrgTag: String?, total: Double, hasRDI: Bool, daily: Double, unit: SubUnit, sub: [Digest]?) {
        self.label = label
        self.tag = tag
        self.schemaOrgTag = schemaOrgTag
        self.total = total
        self.hasRDI = hasRDI
        self.daily = daily
        self.unit = unit
        self.sub = sub
    }
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum SubUnit: String, Codable {
    case g = "g"
    case mg = "mg"
    case µg = "µg"
}

enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case peanutFree = "Peanut-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
}

class Ingredient: Codable {
    let text: String
    let weight: Double
    
    init(text: String, weight: Double) {
        self.text = text
        self.weight = weight
    }
}

class Total: Codable {
    let label: String
    let quantity: Double
    let unit: TotalDailyUnit
    
    init(label: String, quantity: Double, unit: TotalDailyUnit) {
        self.label = label
        self.quantity = quantity
        self.unit = unit
    }
}

enum TotalDailyUnit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

class Params: Codable {
    let sane: [JSONAny]
    let q, appKey, appID: [String]
    
    enum CodingKeys: String, CodingKey {
        case sane, q
        case appKey = "app_key"
        case appID = "app_id"
    }
    
    init(sane: [JSONAny], q: [String], appKey: [String], appID: [String]) {
        self.sane = sane
        self.q = q
        self.appKey = appKey
        self.appID = appID
    }
}

// MARK: Convenience initializers

extension Food {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Food.self, from: data)
        self.init(q: me.q, from: me.from, to: me.to, params: me.params, more: me.more, count: me.count, hits: me.hits)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Hit {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Hit.self, from: data)
        self.init(recipe: me.recipe, bookmarked: me.bookmarked, bought: me.bought)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Recipe {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Recipe.self, from: data)
        self.init(uri: me.uri, label: me.label, image: me.image, source: me.source, url: me.url, shareAs: me.shareAs, yield: me.yield, dietLabels: me.dietLabels, healthLabels: me.healthLabels, cautions: me.cautions, ingredientLines: me.ingredientLines, ingredients: me.ingredients, calories: me.calories, totalWeight: me.totalWeight, totalTime: me.totalTime, totalNutrients: me.totalNutrients, totalDaily: me.totalDaily, digest: me.digest)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Digest {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Digest.self, from: data)
        self.init(label: me.label, tag: me.tag, schemaOrgTag: me.schemaOrgTag, total: me.total, hasRDI: me.hasRDI, daily: me.daily, unit: me.unit, sub: me.sub)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Ingredient {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Ingredient.self, from: data)
        self.init(text: me.text, weight: me.weight)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Total {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Total.self, from: data)
        self.init(label: me.label, quantity: me.quantity, unit: me.unit)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Params {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Params.self, from: data)
        self.init(sane: me.sane, q: me.q, appKey: me.appKey, appID: me.appID)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

