import Foundation

func countOccurrences(word: String, filePath: String) -> Int {
    do {
        let content = try String(contentsOfFile: filePath, encoding: .utf8)
        let words = content.components(separatedBy: .whitespacesAndNewlines)

        var count = 0
        for w in words {
            if w == word {
                count += 1
            }
        }

        return count
    } catch {
        print("Error reading file: \(error)")
        return 0
    }
}

if let wordToCount = readLine() {
  let filePath = "data.txt"

  let occurrenceCount = countOccurrences(word: wordToCount, filePath: filePath)
  print("Occurrences of '\(wordToCount)': \(occurrenceCount)")
} else {
    print("Invalid input.")
}