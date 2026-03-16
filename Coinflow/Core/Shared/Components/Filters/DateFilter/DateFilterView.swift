//
//  DateFilterView.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 18.01.2026.
//

import Foundation
import SwiftUI

struct DateFilterView: View {

    // MARK: - Props

    @Environment(\.dismiss) private var dismiss
    @Binding var startDate: Date
    @Binding var endDate: Date

    // MARK: - UI

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 8) {
                Image("wednesday")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)

                Text("week")
                    .foregroundStyle(.primary)

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                setWeekPeriod()
                dismiss()
            }

            HStack(spacing: 8) {
                Image("october-calendar")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)

                Text("month")
                    .foregroundStyle(.primary)

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                setMonthPeriod()
                dismiss()
            }

            HStack(spacing: 8) {
                Image("calendar-swap")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)

                Text("year")
                    .foregroundStyle(.primary)

                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                setYearPeriod()
                dismiss()
            }

            Divider()

            HStack(spacing: 8) {
                Image("calendar-arrow-down")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)

                DatePicker("startDate", selection: $startDate, displayedComponents: [.date])
                    .datePickerStyle(.compact)
            }

            HStack(spacing: 8) {
                Image("calendar-arrow-up")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)

                DatePicker("endDate", selection: $endDate, displayedComponents: [.date])
                    .datePickerStyle(.compact)
            }
        }
        .padding(15)
        .frame(width: 250, height: 250)
    }

    // MARK: - Methods

    private func setWeekPeriod() {
        startDate = Date.startOfCurrentWeek
        endDate = Date.endOfCurrentWeek
    }

    private func setMonthPeriod() {
        startDate = Date.startOfCurrentMonth
        endDate = Date.endOfCurrentMonth
    }

    private func setYearPeriod() {
        startDate = Date.startOfCurrentYear
        endDate = Date()
    }
}
