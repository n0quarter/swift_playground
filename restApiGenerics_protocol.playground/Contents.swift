
// -------------- Models
protocol iRestApiModel {}

class Brochure : iRestApiModel {
  var id : String = "BrochureID"
}

class Publisher : iRestApiModel {
  var id : String = "PublisherID"
}

// -------------- Json Parser
protocol iJsonParser {
  func parseJson(json: String) -> [iRestApiModel]
}
class BrohureJsonParser: iJsonParser {
  func parseJson(json: String) -> [iRestApiModel] {
    return [Brochure(), Brochure()]
  }
}
class PublisherJsonParser: iJsonParser {
  func parseJson(json: String) -> [iRestApiModel] {
    return [Publisher(), Publisher()]
  }
}

// -------------- Generic Service
class RestApiService {
  
  let parser : iJsonParser
  
  init(parser: iJsonParser) {
    self.parser = parser
  }
  
  func getBrochuresParent(jsonString: String) -> [iRestApiModel] {
    return parser.parseJson(jsonString)
  }
}

// -------------- Specific Service Subclass
class brochureRestApiService : RestApiService{
  let brochureParser = BrohureJsonParser()
  
  init() {
    super.init(parser: brochureParser)
  }
}

// use it directly
let publisherParser = PublisherJsonParser()
let publisherService = RestApiService(parser: publisherParser)
publisherService.getBrochuresParent("kinda_json_string")


//// use via specific subclass
let brochureService = brochureRestApiService()
let brochures1 = brochureService.getBrochuresParent("kinda_json_string")

