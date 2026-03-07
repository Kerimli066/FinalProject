import Foundation

enum EmailValidator {

    private static let allowedTLDs: Set<String> = [
        "com", "net", "org", "edu", "gov", "io",
        "co.uk", "co.in", "co.jp", "co.nz", "co.za", "co.kr",
        "com.au", "com.br", "com.tr", "com.mx", "com.ar",
        "me", "us", "ca", "de", "fr", "ru", "cn", "jp",
        "uk", "au", "in", "az", "eu"
    ]

    private static let knownProviders: Set<String> = [
        "gmail", "yahoo", "hotmail", "outlook", "live",
        "icloud", "me", "mac", "apple",
        "proton", "protonmail",
        "yandex", "mail", "inbox"
    ]

    static func validate(_ raw: String) -> String? {
        let email = raw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if email.isEmpty {
            return "Email address is required."
        }

        guard email.contains("@") else {
            return "Email must include '@' — e.g. name@gmail.com"
        }

        let parts  = email.split(separator: "@", maxSplits: 1, omittingEmptySubsequences: false)
        let local  = parts.count > 0 ? String(parts[0]) : ""
        let domain = parts.count > 1 ? String(parts[1]) : ""

        if local.isEmpty  { return "Enter the part before '@' — e.g. name@gmail.com" }
        if domain.isEmpty { return "Enter a domain after '@' — e.g. gmail.com" }

        guard domain.contains(".") else {
            return "Domain must include '.' — e.g. name@gmail.com"
        }

        // Əsas regex — bütün emaillər üçün
        let regex     = #"^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluate(with: email) else {
            return "Enter a valid email address — e.g. name@gmail.com"
        }

        let domainParts  = domain.split(separator: ".")
        let providerBase = String(domainParts[0])

        if knownProviders.contains(providerBase) {
            let suffix = domainParts.count == 2
                ? String(domainParts[1])
                : domainParts.dropFirst().joined(separator: ".")

            if !allowedTLDs.contains(suffix) {
                if let suggestion = closestTLD(to: suffix) {
                    return "Did you mean \(providerBase).\(suggestion)? — e.g. name@\(providerBase).\(suggestion)"
                } else {
                    return "'\(suffix)' is not allowed — e.g. name@\(providerBase).com"
                }
            }
        }

        return nil
    }

    private static func closestTLD(to input: String) -> String? {
        let common = ["com", "net", "org", "me", "co.uk", "io"]
        var best: String?
        var bestDist = Int.max
        for tld in common {
            let d = levenshtein(input, tld)
            if d < bestDist && d <= 2 { bestDist = d; best = tld }
        }
        return best
    }

    private static func levenshtein(_ a: String, _ b: String) -> Int {
        let a = Array(a), b = Array(b)
        var dp = Array(0...b.count)
        for i in 1...a.count {
            var prev = dp[0]; dp[0] = i
            for j in 1...b.count {
                let temp = dp[j]
                dp[j] = a[i-1] == b[j-1] ? prev : min(prev, min(dp[j], dp[j-1])) + 1
                prev = temp
            }
        }
        return dp[b.count]
    }
}
