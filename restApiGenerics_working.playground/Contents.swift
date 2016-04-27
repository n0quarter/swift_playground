
// -------------- Models
class Brochure {
  var id : String = "BrochureID"
}

class Publisher {
  var id : String = "PublisherID"
}

// -------------- Json Parser
protocol iJsonParser {
  associatedtype ReturnType
  func parseJson(json: String) -> [ReturnType]
}
class BrohureJsonParser: iJsonParser {
  func parseJson(json: String) -> [Brochure] {
    return [Brochure(), Brochure()]
  }
}
class PublisherJsonParser: iJsonParser {
  func parseJson(json: String) -> [Publisher] {
    return [Publisher(), Publisher()]
  }
}

// -------------- Generic Service
class RestApiService<Element, ParserType: iJsonParser where ParserType.ReturnType == Element> {
  
  let parser : ParserType
  
  init(parser: ParserType) {
    self.parser = parser
  }
  
  func getBrochuresParent(jsonString: String) -> [Element] {
    return parser.parseJson(jsonString)
  }
}

// -------------- Specific Service Subclass
class brochureRestApiService : RestApiService<Brochure, BrohureJsonParser>{
  let brochureParser = BrohureJsonParser()
  
  init() {
    super.init(parser: brochureParser)
  }
}

// use it directly
let publisherParser = PublisherJsonParser()
let publisherService = RestApiService<Publisher, PublisherJsonParser>(parser: publisherParser)
publisherService.getBrochuresParent("kinda_json_string")

// use via specific subclass
let brochureService = brochureRestApiService()
let brochures1 = brochureService.getBrochuresParent("kinda_json_string")

