# TinyJson 

TinyJson is simple json api library for ios, written by swift

## Swift Version

This branch supports swift 1.2

## Usage

you have to define
1: object mapper
2: completion handler
3: error handler(optional)

ex:

model

```swift
public class Media {
    var id: Int?
    var caption: String?
}
```

mapper

```swift
var mapper = { (json: Dictionary<String, AnyObject>) -> [Media] in

    var result = [Media]()

    var list = json["data"] as! NSArray

    var array = list as NSArray

    for dic in array {
        let obj = Media()
        obj.id = dic["id"] as? Int
        obj.caption = dic["caption"] as? String

        result.append(obj)
    }
    return result
}
```

completion handler

```swift
var handler = { (array: [Media]) -> () in
    for val in array {
        println(val)
    }
}
```

how to call API
```swift
var params = [String: AnyObject]()
params["id"] = 12

var url = "http://eli.lvh.me/media/list"
var request = APIRequest<[Media]>(url: url, method: .GET, jsonMapper: mapper, completionHandler: handler)
var cached = JsonAPI.call(request, params: params)
```

### Cache
TODO


