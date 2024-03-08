//
//  SearchTextfield.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/7/24.
//

import SwiftUI
import Combine

// methods we can use in our DropDownListProtocols
public protocol DropdownListProtocol {
    // getList returns a filtered list based on what the user searches/enters in textfield
    // Ex: if user types "PA" we show the "PAPHA" facility
    func getList(queryParam: String) -> [DropdownOption]
}

// DropdownOptions makes our entries hashable
public struct DropdownOption: Hashable {
    let key: String
    let value: String
    
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}

// DropdownRow makes each entry into a button
// Ex: the "PAPHA" facility is clickable so we can select a facility
public struct DropdownRow: View {
    var option: DropdownOption // option is our list item (Ex: PAPHA)
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    public var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text(self.option.value)
                    .font(.system(size: 17))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(10)
    }
}


// Dropdown creates a scrollable view incase we have multiple dropdown entries
// EX: 100 entries in the dropdown list
public struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // filter here
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                    Divider()
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 40, maxHeight: 250)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

// SearchTextfieldWithDropdown combines everything we created above, our search textfield with a dropdown
public struct SearchTextfield: View {
    
    let showDropdownFlag: Bool                                  // this parameter determines if we should show a dropdown
    @State private var shouldShowDropdown = false               // set this to true, if user clicks on textfield and shouldShowDropdown is true
    @State private var selectedOption: DropdownOption? = nil    // option the user selects
    @Binding var textfieldText: String                          // what the user types in the textfield
    @State private var options: [DropdownOption] = []           // dropdown options
    var optionProvider: DropdownListProtocol                    // used to access protocol methods
    var placeholder: String                                     // search textfield placeholder
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    public private(set) var buttonHeight: CGFloat = 50
    public private(set) var searchImage: UIImage?
    
    public init(showDropDownFlag: Bool, textfieldText: Binding<String>, optionProvider: DropdownListProtocol, placeholder: String, onOptionSelected: @escaping (_ option: DropdownOption) -> Void, buttonHeight: CGFloat, searchImage: UIImage?) {
        self.showDropdownFlag = showDropDownFlag
        _textfieldText = textfieldText
        self.optionProvider = optionProvider
        self.placeholder = placeholder
        self.onOptionSelected = onOptionSelected
        self.buttonHeight = buttonHeight
        self.searchImage = searchImage
    }
  
    public var body: some View {
        // HStack creates our search textfield which consists of an image and search
        HStack{
            if let searchImage = searchImage {
                Image(uiImage: searchImage)
            }
            TextField(placeholder, text:$textfieldText)
                .onTapGesture {
                    // check if we should show dropdown when user clicks on textfield
                    if self.showDropdownFlag {
                        self.shouldShowDropdown = true
                    }
                }
                .onReceive(textfieldText.publisher) { _ in
                    // if what the user types does not match a dropdown option, keep showing dropdown
                    if (selectedOption?.value != textfieldText) {
                        self.shouldShowDropdown = true
                        selectedOption = nil
                    }
                    
                }
        }
        .padding(.horizontal)
        .cornerRadius(5)
        .frame(width: .infinity, height: self.buttonHeight)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).foregroundColor(Color.gray))
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: optionProvider.getList(queryParam: textfieldText), onOptionSelected: { option in
                        selectedOption = option
                        textfieldText = selectedOption!.value
                        self.onOptionSelected?(option)
                        shouldShowDropdown = false
                    })
                }
            }, alignment: .topLeading
        )
    }
}


struct FacilitiesDropdownList: DropdownListProtocol {
    // give each facility a unique identifier value
    var uniqueKey: String {
        UUID().uuidString
    }
    
    func getList(queryParam: String) -> [DropdownOption] {
        // facility list
        let facilityOptions: [DropdownOption] = [
            DropdownOption(key: uniqueKey, value: "PAPHA"),
            DropdownOption(key: uniqueKey, value: "MANOR"),
            DropdownOption(key: uniqueKey, value: "NJLGN"),
            DropdownOption(key: uniqueKey, value: "SB"),
        ]
        // return filtered facility list based on user text input
        return facilityOptions.filter { option in
            return option.value.uppercased().hasPrefix(queryParam.uppercased())
        }
    }
}


// Used to preview component
struct SearchTextfield_Previews: PreviewProvider {
    static var previews: some View {

        @State var text: String = ""
        let searchImage = UIImage(systemName: "heart.fill")
        VStack{
            ZStack{
                SearchTextfield(showDropDownFlag: true, textfieldText: $text, optionProvider: FacilitiesDropdownList(), placeholder: "", onOptionSelected: { _ in }, buttonHeight: 50, searchImage: searchImage)
                    .padding(.horizontal)
            }
        }
    }
}



