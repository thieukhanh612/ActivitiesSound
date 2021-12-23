//
//  DropBox.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 27/11/2021.
//

import SwiftUI
struct DropdownOption: Hashable {
    let key: String
    let value: String
    
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
struct DropBox: View {
    @Binding var shouldShowDropdown: Bool
    @State private var selectedOption: DropdownOption? = nil
    var placeholder: String
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    private let buttonHeight: CGFloat = 45
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
     
            VStack {
                Button(action: {
                    self.shouldShowDropdown.toggle()
                }) {
                    HStack {
                        Text(selectedOption == nil ? placeholder : selectedOption!.value)
                            .font(.system(size: 14))
                            .foregroundColor(selectedOption == nil ? Color.gray: Color("TextColor"))
                        
                        Spacer()
                        
                        Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 9, height: 5)
                            .font(Font.system(size: 9, weight: .medium))
                            .foregroundColor(Color("TextColor"))
                    }
                }
                .padding(.horizontal)
                .cornerRadius(5)
                .frame(width: .infinity, height: self.buttonHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay(
                    VStack {
                        if self.shouldShowDropdown {
                            Spacer(minLength: buttonHeight + 10)
                            Dropdown(options: self.options, onOptionSelected: { option in
                                shouldShowDropdown = false
                                selectedOption = option
                                self.onOptionSelected?(option)
                            }, playerViewModel: playerViewModel)
                        }
                    }, alignment: .topLeading
                )
                .background(
                    RoundedRectangle(cornerRadius: 5).fill(Color("BackgroundDefaultColor"))
                )
            }
     
    }
}

struct DropBox_Previews: PreviewProvider {
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Normal cooking"),
        DropdownOption(key: uniqueKey, value: "Making cake"),
        DropdownOption(key: uniqueKey, value: "Outside cooking"),
        DropdownOption(key: uniqueKey, value: "Workout"),
        DropdownOption(key: uniqueKey, value: "Walking"),
        DropdownOption(key: uniqueKey, value: "Skilled trades"),
        DropdownOption(key: uniqueKey, value: "Technical"),
        DropdownOption(key: uniqueKey, value: "Tatical games"),
        DropdownOption(key: uniqueKey, value: "Video games"),
        DropdownOption(key: uniqueKey, value: "Housework"),
        DropdownOption(key: uniqueKey, value: "Sleeping"),
        DropdownOption(key: uniqueKey, value: "Chillout"),
        DropdownOption(key: uniqueKey, value: "Fun mood"),
        DropdownOption(key: uniqueKey, value: "Sad mood"),
        DropdownOption(key: uniqueKey, value: "Dance")
    ]
    static var previews: some View {
        Group {
            DropBox(
                shouldShowDropdown: Binding.constant(false),
                placeholder: "Day of the week",
                options: options,
                onOptionSelected: { option in
                    print(option)
                }, playerViewModel: PlayerViewModel())
                .padding(.horizontal)
        }
    }
}
struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected, playerViewModel:playerViewModel)
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 450)
        .padding(.vertical, 5)
        .background(Color("BackgroundDefaultColor"))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("SubTextColor"), lineWidth: 1)
        )
    }
}
struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
            
                Button(action: {
                    if let onOptionSelected = self.onOptionSelected {
                        onOptionSelected(self.option)
                    }
                }) {
                    HStack {
                        Text(self.option.value)
                            .foregroundColor(Color("TextColor"))
                            .font(.system(size: 20))
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
            .padding(.vertical, 10)
        
        
    }
}
