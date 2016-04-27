
// -------------- Models
class Brochure {
  var id : String = "BrochureID"
}

class Publisher {
  var id : String = "PublisherID"
}

// -------------- Json Parser
class AbstractJsonParser<Element> {

  internal func parseJson(json: String) -> [Element] {
    fatalError(#function + "Must be overridden");
  }
}
class BrohureJsonParser: AbstractJsonParser<Brochure> {
  override func parseJson(json: String) -> [Brochure] {
    return [Brochure(), Brochure()]
  }
}
class PublisherJsonParser: AbstractJsonParser<Publisher> {
  override func parseJson(json: String) -> [Publisher] {
    return [Publisher(), Publisher()]
  }
}

// -------------- Generic Service
class RestApiService<Element> {
  
  let parser : AbstractJsonParser<Element>
  
  init(parser: AbstractJsonParser<Element>) {
    self.parser = parser
  }
  
  func getBrochuresParent(jsonString: String) -> [Element] {
    return parser.parseJson(jsonString)
  }
}

// -------------- Specific Service Subclass
class brochureRestApiService : RestApiService<Brochure>{
  let brochureParser = BrohureJsonParser()
  
  init() {
    super.init(parser: brochureParser)
  }
}

// use it directly
let publisherService = RestApiService<Publisher>(parser: PublisherJsonParser())
publisherService.getBrochuresParent("kinda_json_string")

// use via specific subclass
let brochureService = brochureRestApiService()
let brochures1 = brochureService.getBrochuresParent("kinda_json_string")


