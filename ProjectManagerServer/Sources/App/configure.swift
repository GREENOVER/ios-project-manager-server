import Vapor
import Fluent
import FluentMongoDriver

public func configure(_ app: Application) throws {

    try app.databases.use(.mongo(connectionString: "<connection string>"), as: .mongo)
    try routes(app)
}
