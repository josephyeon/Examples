import UIKit
import Foundation
// "type=TN002&uid=U000&cidC000=&oidO000&eid=E000"
let url = "lupick://link"
var components = URLComponents(string: url)

let type = URLQueryItem(name: "type", value: "TN002")
let uid = URLQueryItem(name: "uid", value: "U000")
let cid = URLQueryItem(name: "cid", value: "C000")
let oid = URLQueryItem(name: "oid", value: "O000")
let eid = URLQueryItem(name: "eid", value: "E000")

components?.queryItems = [type, uid, cid, oid, eid]
print(components?.queryItems)

let newURL = components?.url

var dict = [String: Any]()

if let queryItems = components?.queryItems {
    for item in queryItems {
        dict[item.name] = item.value
    }
}

print(dict)
