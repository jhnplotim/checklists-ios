// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L {

  internal enum App {
    /// Checklists
    internal static let name = L.tr("Localizable", "app.name")
  }

  internal enum Button {
    /// All
    internal static let all = L.tr("Localizable", "button.all")
    /// Cancel
    internal static let cancel = L.tr("Localizable", "button.cancel")
    /// Close
    internal static let close = L.tr("Localizable", "button.close")
    /// Confirm
    internal static let confirm = L.tr("Localizable", "button.Confirm")
    /// Delete
    internal static let delete = L.tr("Localizable", "button.delete")
    /// Done
    internal static let done = L.tr("Localizable", "button.done")
    /// No
    internal static let no = L.tr("Localizable", "button.no")
    /// OK
    internal static let ok = L.tr("Localizable", "button.ok")
    /// Recover
    internal static let recover = L.tr("Localizable", "button.recover")
    /// Send Data
    internal static let sendData = L.tr("Localizable", "button.sendData")
    /// Settings
    internal static let settings = L.tr("Localizable", "button.settings")
    /// Try Again
    internal static let tryAgain = L.tr("Localizable", "button.tryAgain")
    /// Yes
    internal static let yes = L.tr("Localizable", "button.yes")
  }

  internal enum Feature {
    internal enum Alllists {
      /// Checklists
      internal static let title = L.tr("Localizable", "feature.alllists.title")
    }
    internal enum Checklist {
      internal enum Default {
        /// Shopping
        internal static let name = L.tr("Localizable", "feature.checklist.default.name")
      }
      internal enum Iconpicker {
        /// Choose Icon
        internal static let title = L.tr("Localizable", "feature.checklist.iconpicker.title")
      }
      internal enum State {
        internal enum Allitemsdone {
          /// All done!
          internal static let label = L.tr("Localizable", "feature.checklist.state.allitemsdone.label")
        }
        internal enum Itemsremaining {
          /// %d Remaining
          internal static func label(_ p1: Int) -> String {
            return L.tr("Localizable", "feature.checklist.state.itemsremaining.label", p1)
          }
        }
        internal enum Noitems {
          /// (No Items)
          internal static let label = L.tr("Localizable", "feature.checklist.state.noitems.label")
        }
      }
    }
    internal enum Checklistitemdetail {
      internal enum Add {
        /// Add Item
        internal static let title = L.tr("Localizable", "feature.checklistitemdetail.add.title")
      }
      internal enum Edit {
        /// Edit Item
        internal static let title = L.tr("Localizable", "feature.checklistitemdetail.edit.title")
      }
      internal enum Textfield {
        /// Name of the item
        internal static let placeholder = L.tr("Localizable", "feature.checklistitemdetail.textfield.placeholder")
      }
    }
    internal enum Checklists {
      /// Checklists
      internal static let title = L.tr("Localizable", "feature.checklists.title")
    }
    internal enum Listdetail {
      internal enum Add {
        /// Add List
        internal static let title = L.tr("Localizable", "feature.listdetail.add.title")
      }
      internal enum Edit {
        /// Edit List
        internal static let title = L.tr("Localizable", "feature.listdetail.edit.title")
      }
      internal enum Icon {
        /// Icon
        internal static let title = L.tr("Localizable", "feature.listdetail.icon.title")
      }
      internal enum Textfield {
        /// Name of the List
        internal static let placeholder = L.tr("Localizable", "feature.listdetail.textfield.placeholder")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
