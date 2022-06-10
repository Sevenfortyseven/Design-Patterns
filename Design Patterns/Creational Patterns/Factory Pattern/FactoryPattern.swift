//
//  FactoryPattern.swift
//  Design Patterns
//
//  Created by aleksandre on 10.06.22.
//

/* • A factory’s goal is to isolate object creation logic within its own construct.
   • A factory is most useful if you have a group of related products, or if you cannot create an object until more information is supplied (such as completing a network call, or waiting on user input).
   • The factory method adds a layer of abstraction to create objects, which reduces duplicate code. */


import Foundation

public struct JobApplicant {
    public let name: String
    public let email: String
    public var status: Status
    
    public enum Status {
        case new
        case interview
        case hired
        case rejected
    }
    
}

public struct Email {
    public let subject: String
    public let messageBody: String
    public let recipientEail: String
    public let senderEmail: String
    
}


// MARK: -- Factory
public struct EmailFactory {
    
    public let senderEmail: String
    
    public func createEmail(to recipient: JobApplicant) -> Email {
        let subject: String
        let messageBody: String
        
        switch recipient.status{
        case .new:
            subject = "We received your application"
            messageBody = "Thanks for applying for a job here! " +
            "You should hear from us in 17-42 business days."
        case .interview:
            subject = "We Want to Interview You"
            messageBody = "Thanks for your resume, \(recipient.name)! " +
            "Can you come in for an interview in 30 minutes?"
        case .hired:
            subject = "We Want to Hire You"
            messageBody = "Congratulations, \(recipient.name)! " +
            "We liked your code, and you smelled nice. " +
            "We want to offer you a position! Cha-ching! $$$"
        case .rejected:
            subject = "Thanks for Your Application"
            messageBody = "Thank you for applying, \(recipient.name)! " +
            "We have decided to move forward " +
            "with other candidates. " +
            "Please remember to wear pants next time!"
        }
        
        return Email(subject: subject, messageBody: messageBody, recipientEail: recipient.email, senderEmail: senderEmail)
    }
    
    
}

// MARK: -- Usage Example

class FactoryPatternTest {
    var jackson = JobApplicant(name: "Jackson Smith", email: "JacksonSmith@example.com", status: .new)
    let emailFactory = EmailFactory(senderEmail: "RayMines@gmail.com")
    
    private func sendEmail() {
        
        // create Products
        
        // New
        print(emailFactory.createEmail(to: jackson))
        
        // interview
        jackson.status = .interview
        print(emailFactory.createEmail(to: jackson))
        
        // hire
        jackson.status = .hired
        print(emailFactory.createEmail(to: jackson))
    }
}
