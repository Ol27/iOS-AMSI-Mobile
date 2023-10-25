//
//  Job.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import UIKit

struct Job {
    let name: String
    let company: String
    let hourlyRate: String
    let type: String
    let additionalInfo: String
    let distance: String
    let datePublished: String
    let image: UIImage
}

let mockJobs: [Job] = Array(repeating: .init(name: "UI Researcher",
                                             company: "Pinterest",
                                             hourlyRate: "£‎45 (hourly)",
                                             type: "Full time",
                                             additionalInfo: "Need 2 person",
                                             distance: "250 miles",
                                             datePublished: "27 min ago",
                                             image: Assets.Images.Mocks.jobMock.image),
                            count: 5)
