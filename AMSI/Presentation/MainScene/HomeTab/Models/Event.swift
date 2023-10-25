//
//  Event.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import UIKit

struct Event {
    let name: String
    let city: String
    let time: String
    let dayDate: String
    let monthDate: String
    let image: UIImage
    let weekDay: String
    let endTime: String
    let address: String
    let phone: String
    let aboutInfo: String
}

let mockEvents: [Event] = Array(repeating: .init(name: "Some event name special big name event",
                                                 city: "California",
                                                 time: "10:00 PM",
                                                 dayDate: "29",
                                                 monthDate: "Mar",
                                                 image: Assets.Images.Mocks.eventMock.image,
                                                 weekDay: "Friday",
                                                 endTime: "End",
                                                 address: "Street, 3, California, USA",
                                                 phone: "+1 100 12 467",
                                                 aboutInfo: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sit amet lacus ac urna imperdiet tristique eu non tellus. Nunc in ipsum quam. Nulla enim elit, molestie volutpat ullam Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sit amet lacus ac urna imperdiet tristique eu non tellus. Nunc in ipsum quam. Nulla enim elit, molestie volutpat ullam"),
                                count: 10)
