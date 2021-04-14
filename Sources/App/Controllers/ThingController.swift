import Vapor
import Fluent

struct ThingController: RouteCollection {
    private let jsonEncoder: JSONEncoder = JSONEncoder()
    
    func boot(routes: RoutesBuilder) throws {
        let things = routes.grouped(Thing.schema.pathComponents)
        things.get(use: showAll)
        things.post(use: create)
        things.group(":id") { things in
            things.delete(use: delete)
            things.patch(use: update)
        }
    }
    
    func showAll(req: Request) throws -> EventLoopFuture<[Thing]> {
        return Thing.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<Thing> {
        let thing = try req.content.decode(Thing.self)
        return thing.create(on: req.db).map { thing }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Thing.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
    func update(req: Request) throws -> EventLoopFuture<Response> {
        let thing = try req.content.decode(Thing.self)
        let editThing = try req.content.decode(EditThing.self)
        
        return Thing.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { item in
                if let title = editThing.title {
                    thing.title = title
                }
                if let description = editThing.description {
                    thing.description = description
                }
                if let state = editThing.state {
                    thing.state = state
                }
                if let dueDate = editThing.dueDate {
                    thing.dueDate = dueDate
                }
                things.save(on: req.db)
                
                let body = try jsonEncoder.encode(thing)
                return Response(status: .ok, headers: ["Content-Type": "application/json; charset=utf-8"], body: .init(data: body))
        }
    }
}
