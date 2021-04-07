enum Dot {
    static let duration: Double = 0.15
    static let intensity: Float = 1.0
    static let sharpness: Float = 1.0
}

enum Dash {
    static let duration: Double = 0.2
    static let intensity: Float = 1.0
    static let sharpness: Float = 0.0
}

enum Time {
    static let start: Double = 0.0
    static let offset: Double = 0.1
}

public enum Lang: String {
    case morse, dots
}
