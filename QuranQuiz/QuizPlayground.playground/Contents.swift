import Foundation


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

// MARK: - SurahElement
struct SurahElement: Codable, Identifiable, Hashable {
    static func == (lhs: SurahElement, rhs: SurahElement) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    let name, transliteration: String
    let type: TypeEnum
    let totalVerses: Int
    let verses: [Verse]

    enum CodingKeys: String, CodingKey {
        case id, name, transliteration, type
        case totalVerses = "total_verses"
        case verses
    }
}

enum TypeEnum: String, Codable {
    case meccan = "meccan"
    case medinan = "medinan"
}

// MARK: - Verse
struct Verse: Codable, Identifiable {
    var id: Int
    let text: String
    let translation: String
}

typealias Surahs = [SurahElement]

struct QuizVerse: Identifiable, Hashable {
    let id = UUID()
    let surahId: Int
    let ayahId: Int
    let text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(surahId)
        hasher.combine(ayahId)
        hasher.combine(text)
    }
}



//let verses = Array(Bundle.main.decode(SurahElement.self, from: "Al-Fatihah.json").verses.map {
//    QuizVerse(
//        surahId: 1,
//        ayahId: $0.id,
//        text: $0.text
//    )
//}.prefix(4))

let surahs = Bundle.main.decode(Surahs.self, from: "Quran_ur.json")
