import UIKit

extension Date {
    static func toDate(n : Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: n, to: Date())!
    }
}

enum RoomType : Int {
    case semi_deluxe = 2500
    case deluxe = 3000
    case executive = 4000
}

enum PaymentType{
    case notPaid
    case paid
    case fullPaid
}

enum BookingStatus{
    case notBooked
    case book
    case cancel
}

protocol PersonProtocol{
    var name : String {get}
    var age : Int {get set}
    var phoneNumber : Int {get set}
    var emailID: String{get}
    
}

protocol GuestProtocol : PersonProtocol{
    var numberOfDays : Int{get}
    var check_in : Date{get set}
    var check_out : Date{get}
    var roomType : RoomType {get set}
    var amountPaid : Int {get set}
    var payment : PaymentType{get}
    var numberOfRooms : Int {get}
    var bookingStatus : BookingStatus{get set}
    var roomNumber : [Int]{get set}
    
    
    func printGuestDetails()
    func assingingRoomNumber()
    func booking(status : BookingStatus)
    
}


class Guest : GuestProtocol{
    var name: String
    var age: Int
    var phoneNumber: Int
    var emailID: String
    
    var numberOfDays: Int
    var check_in: Date
    var check_out : Date {
        get{
            return Date.toDate(n: self.numberOfDays)
        }
        
    }
    var roomType: RoomType
    var amountPaid: Int
    var payment : PaymentType{
            switch self.amountPaid {
            case 0:
                return .notPaid
            default:
                return self.balanceAmount() == 0 ?  .fullPaid : .paid
            }
    }
    var numberOfRooms: Int = 1
    var bookingStatus: BookingStatus = .notBooked
    var roomNumber: [Int] = []
    

    init(name : String , age : Int , phoneNumber : Int, emailID : String, check_in : Date, numberOfDays : Int, roomType : RoomType, amountPaid : Int, numberOfRooms : Int = 1) {
            self.name = name
            self.age = age
            self.phoneNumber = phoneNumber
            self.emailID = emailID
            self.check_in = check_in
            self.numberOfDays = numberOfDays
            self.roomType = roomType
            self.amountPaid = amountPaid
            self.numberOfRooms = numberOfRooms
            self.assingingRoomNumber()
        }
    
    func printGuestDetails(){
        print("Name : \(name) , Age : \(age), phone number : \(phoneNumber), check-in : \(check_in), check-out : \(check_out), room number alloted : \(roomNumber), roomtype : \(roomType), amount paid : \(amountPaid), Booking status : \(bookingStatus)")
    }
    
    func booking(status : BookingStatus){
        switch status {
        case .book:
            if payment == .notPaid {
                print("Please pay to book")
            }else{
                
                print("Your \(roomNumber.count) \(self.roomType) room has been booked.Balance to be paid \(self.balanceAmount()) ")
            }
        case .cancel :
            self.roomNumber.removeAll()
            self.bookingStatus = .cancel
            print("Your booking with us has been cancelled.\(Double(self.amountPaid/2)) will be refunded")
        default:
            print("Please book a Room")
        }
    }

    private func balanceAmount() -> Int{
        return self.numberOfDays * self.roomType.rawValue - self.amountPaid
    }
    
    func assingingRoomNumber(){
        for _ in 1...self.numberOfRooms{
            roomNumber.append(Int.random(in: 1...100))
        }
    }

}

let guest = Guest(name: "Sharvari", age: 26, phoneNumber: 9078563412, emailID: "Sharvari.hv@quest-global.com", check_in: Date(), numberOfDays: 2, roomType: .deluxe, amountPaid: 2000)
guest.printGuestDetails()
guest.booking(status: .book)
guest.booking(status: .cancel)


