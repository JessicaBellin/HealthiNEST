


import Foundation

struct User: Codeable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    let password: String
}