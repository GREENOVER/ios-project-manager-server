import Vapor
import Fluent

struct EditItem: Content {
    let title: String?
    let description: String?
    let state: State?
    let dueDate: Double?
    
    enum CodingKeys: String, CodingKey {
        case title, description, state, dueDate
    }
}

