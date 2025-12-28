//
//  PageControl.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 17.12.2025.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.systemBlue
        control.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        control.currentPageIndicatorTintColor = .appPrimary
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
