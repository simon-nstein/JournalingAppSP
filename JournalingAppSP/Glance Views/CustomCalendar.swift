import SwiftUI

struct CustomCalendar: View {
    
    @ObservedObject var viewModel: JournalData
    @EnvironmentObject var sharedData: SharedData
    private let calendar = Calendar.current
    private let monthFormatter = DateFormatter(dateFormat: "MMMM YYYY", calendar: Calendar.current)
    private let dayFormatter = DateFormatter(dateFormat: "d", calendar: Calendar.current)
    private let weekDayFormatter = DateFormatter(dateFormat: "EEE", calendar: Calendar.current)
    private let fullFormatter = DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: Calendar.current)

    @State private var selectedDate = Date()
    
    func NEWdateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd" // the way the date is formatted in HistoryView
            return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack {
            CustomCalendarComponent(
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    ZStack {
                        Button(action: {
                            selectedDate = date
                            if (dotDate(nonStringDate: selectedDate)) {
                                sharedData.selectedDate = NEWdateToString(date: selectedDate)
                                sharedData.sharedVariable.toggle()
                            }
                        }) {
                            
                            Text(dayFormatter.string(from: date))
                                .frame(minWidth: 0, maxWidth: 21) //helps the size of the cirlce
                                //.font(.custom("Poppins-Regular", size: 16))
                                .padding(6)
                                .foregroundColor(calendar.isDateInToday(date) ? Color.white : .primary)
                                .background(
                                    calendar.isDateInToday(date) ? Color.gray //if date is today background color is gray
                                    : calendar.isDate(date, inSameDayAs: selectedDate) ? Color("CalendarCircle") //If date is the same day as a selectedDate
                                    : .clear //if neither of those two
                                )
                                .cornerRadius(100)
                        }

                        if (dotDate(nonStringDate: date)) {
                            Circle()
                                .size(CGSize(width: 5, height: 5))
                                .foregroundColor(Color.red)
                                .offset(x: CGFloat(16), y: CGFloat(30))
                                    //fix the x offset
                        }
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        //.cornerRadius(100)
                        .foregroundColor(Color("CalendarDaysOfWeek"))
                    
                        //.font(.custom("Poppins-Regular", size: 16))
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date))//.fontWeight(.bold)
                        .font(.custom("Poppins-SemiBold", size: 15))
                        .foregroundColor(Color("CalendarDaysOfWeek"))
                },
                title: { date in
                    HStack {
                        Text(monthFormatter.string(from: date))
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 6)
                            .foregroundColor(Color("CalendarHeader"))
                        
                        HStack{
                            
                            Button {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: -1,
                                    to: selectedDate
                                ) else {
                                    return
                                }

                                selectedDate = newDate
                            } label: {
                                Label(
                                    title: { Text("Previous") },
                                    icon: {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(Color("CalendarHeader"))
                                            .font(.system(size: 20))

                                    }
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                            
                            Button {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: 1,
                                    to: selectedDate
                                ) else {
                                    return
                                }

                                selectedDate = newDate

                            } label: {
                                Label(
                                    title: { Text("Next") },
                                    icon: {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color("CalendarHeader"))
                                            .font(.system(size: 20))

                                    }
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                        }

                        
                    }
                    .padding(.bottom, 5)
                    .padding(.top)
                }
            )
            .equatable()
        }
        //.padding()
        
    }
    
    func dotDate(nonStringDate: Date) -> Bool {

         if viewModel.getRBT(with: viewModel.savedRoses, stringDate: dateToString(date: nonStringDate)) != nil || viewModel.getGrat(array: viewModel.savedGratitudes, stringDate: dateToString(date: nonStringDate), whichInput: "Input1")?["message"] != nil || viewModel.getOpen(with: viewModel.savedOpens, stringDate: dateToString(date: nonStringDate)) != nil {
             return true
         }

        return false
    }//end func
    
}

// MARK: - Component

public struct CustomCalendarComponent<Day: View, Header: View, Title: View, Trailing: View>: View {
    // Injected dependencies
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let trailing: (Date) -> Trailing
    private let header: (Date) -> Header
    private let title: (Date) -> Title

    // Constants
    private let daysInWeek = 7

    //@FetchRequest var fixtures: FetchedResults<Fixture>

    public init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder trailing: @escaping (Date) -> Trailing,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.trailing = trailing
        self.header = header
        self.title = title
    }

    public var body: some View {

        let month = date.startOfMonth(using: calendar)
        let days = makeDays()

        //VStack {

            //Section(header: title(month)) { }

            VStack {
                Section(header: title(month)) { }

                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                }

                LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
                    ForEach(days, id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date)
                        } else {
                            trailing(date)
                        }
                    }
                }
            }
            .frame(width: 300, height: days.count == 42 ? 320 : 290)
            .background(Color("CalendarBackground")) //background of calendar box
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: 5)
            
             
        //}
    }
}

// MARK: - Conformances

extension CustomCalendarComponent: Equatable {
    public static func == (lhs: CustomCalendarComponent<Day, Header, Title, Trailing>, rhs: CustomCalendarComponent<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CustomCalendarComponent {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }

        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]

        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }

            guard date < dateInterval.end else {
                stop = true
                return
            }

            dates.append(date)
        }

        return dates
    }

    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

// MARK: - Previews

#if DEBUG
struct CustomCalendar_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendar(
            //calendar: Calendar(identifier: .gregorian)
            viewModel: JournalData(UserProfile: Profile.empty)
        )
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
