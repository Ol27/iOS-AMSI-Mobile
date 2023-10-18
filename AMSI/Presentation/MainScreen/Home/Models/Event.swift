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
}

let MockEvents: [Event] = Array(repeating: .init(name: "Some event name special big name event",
                                                 city: "California",
                                                 time: "10:00 PM",
                                                 dayDate: "29",
                                                 monthDate: "Mar",
                                                 image: Assets.Images.Mocks.eventMock.image),
                                count: 5)
