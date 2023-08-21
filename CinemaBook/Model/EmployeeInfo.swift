


import Foundation
import ObjectMapper

struct EmployeeModel: Mappable {
    var message = 0
    var data = Employee()
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}
struct Employee: Mappable {
  var employeeId = 0
  var fullName = ""
  var phone = ""
  var email = ""
  var address = ""
  var birthday = ""
  var roleId = 0
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
          employeeId <- map["employeeId"]
          fullName <- map["fullName"]
         phone <- map["phone"]
         email <- map["email"]
         address <- map["address"]
         birthday <- map["birthday"]
         roleId <- map["roleId"]
    }
}
