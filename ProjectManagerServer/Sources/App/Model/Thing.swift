import Vapor
import Fluent

final class Thing: Model, Content {
    static let schema = "things"
    
    @ID(key: .id)
    var id: UUID
    
    @Field(key: "title")
    var title: String?
    
    @Field(key: "description")
    var description: String?
    
    @Field(key: "state")
    var state: String
    
    @Field(key: "due_date")
    var dueDate: Double
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Double
    
    init() {}
    
    init(id: UUID, title: String? = nil, description: String? = nil, state: String, dueDate: Double, updateAt: Double) {
        self.id = id
        self.name = name
        self.fileName = fileName
        self.fileType = fileType
        self.content = content
    }
}
