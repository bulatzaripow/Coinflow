//
//  CurrencyService.swift
//  Coinflow
//
//  Created by Bulat Zaripov on 20.12.2025.
//

import Foundation
import SwiftData

final class CurrencyService: CurrencyInitializerProtocol {
    
    // MARK: - Props
    
    let context: ModelContext
    
    // MARK: - Init
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Methods
    
    func setupDefaultCurrenciesIfNeeded() {
        guard !checkIfCurrenciesExist() else {
            print("Currencies already exist in database")
            return
        }
        
        _ = createDefaultCurrencies()
        print("Created all default currencies")
        
        // Saving data
        do {
            try context.save()
        } catch {
            print("Error saving currencies: \(error)")
        }
    }
    
    func detectUserCurrency() -> String {
        let userLocale = Locale.current
        
        if let currencyCode = userLocale.currency?.identifier {
            return currencyCode
        }
        
        return "USD"
    }
    
    private func createDefaultCurrencies() -> [Currency] {
        let defaultCurrencies = getDefaultCurrencies()
        var currencies: [Currency] = []
        
        for currencyData in defaultCurrencies {
            let currency = Currency(
                code: currencyData.code,
                symbol: currencyData.symbol,
                name: currencyData.name,
                createdAt: Date()
            )
            context.insert(currency)
            currencies.append(currency)
        }
        
        return currencies
    }

    private func getDefaultCurrencies() -> [(code: String, symbol: String, name: String)] {
        return [
            // Worldwide
            ("USD", "$", "US Dollar"),
            ("EUR", "€", "Euro"),
            ("GBP", "£", "British Pound"),
            ("JPY", "¥", "Japanese Yen"),
            ("CNY", "¥", "Chinese Yuan"),
            ("CHF", "CHF", "Swiss Franc"),
            ("CAD", "C$", "Canadian Dollar"),
            ("AUD", "A$", "Australian Dollar"),
            ("NZD", "NZ$", "New Zealand Dollar"),
            
            // Europe
            ("RUB", "₽", "Russian Ruble"),
            ("UAH", "₴", "Ukrainian Hryvnia"),
            ("BYN", "Br", "Belarusian Ruble"),
            ("PLN", "zł", "Polish Złoty"),
            ("CZK", "Kč", "Czech Koruna"),
            ("SEK", "kr", "Swedish Krona"),
            ("NOK", "kr", "Norwegian Krone"),
            ("DKK", "kr", "Danish Krone"),
            ("HUF", "Ft", "Hungarian Forint"),
            ("RON", "lei", "Romanian Leu"),
            ("BGN", "лв", "Bulgarian Lev"),
            ("HRK", "kn", "Croatian Kuna"),
            ("RSD", "дин", "Serbian Dinar"),
            
            // Azia
            ("INR", "₹", "Indian Rupee"),
            ("KRW", "₩", "South Korean Won"),
            ("SGD", "S$", "Singapore Dollar"),
            ("HKD", "HK$", "Hong Kong Dollar"),
            ("TWD", "NT$", "New Taiwan Dollar"),
            ("MYR", "RM", "Malaysian Ringgit"),
            ("THB", "฿", "Thai Baht"),
            ("IDR", "Rp", "Indonesian Rupiah"),
            ("PHP", "₱", "Philippine Peso"),
            ("VND", "₫", "Vietnamese Đồng"),
            
            // Middle East
            ("AED", "د.إ", "UAE Dirham"),
            ("SAR", "﷼", "Saudi Riyal"),
            ("QAR", "﷼", "Qatari Riyal"),
            ("KWD", "د.ك", "Kuwaiti Dinar"),
            ("BHD", ".د.ب", "Bahraini Dinar"),
            ("OMR", "﷼", "Omani Rial"),
            ("JOD", "د.ا", "Jordanian Dinar"),
            ("ILS", "₪", "Israeli Shekel"),
            ("TRY", "₺", "Turkish Lira"),
            ("IRR", "﷼", "Iranian Rial"),
            
            // Africa
            ("ZAR", "R", "South African Rand"),
            ("EGP", "ج.م", "Egyptian Pound"),
            ("NGN", "₦", "Nigerian Naira"),
            ("MAD", "د.م.", "Moroccan Dirham"),
            ("DZD", "د.ج", "Algerian Dinar"),
            ("TND", "د.ت", "Tunisian Dinar"),
            
            // Latin America
            ("BRL", "R$", "Brazilian Real"),
            ("MXN", "$", "Mexican Peso"),
            ("ARS", "$", "Argentine Peso"),
            ("CLP", "$", "Chilean Peso"),
            ("COP", "$", "Colombian Peso"),
            ("PEN", "S/", "Peruvian Sol"),
            ("UYU", "$", "Uruguayan Peso"),
            ("PYG", "₲", "Paraguayan Guaraní"),
            ("BOB", "Bs", "Bolivian Boliviano"),
            ("CRC", "₡", "Costa Rican Colón"),
            
            // Other
            ("KZT", "₸", "Kazakhstani Tenge"),
            ("UZS", "сўм", "Uzbekistani Som"),
            ("AZN", "₼", "Azerbaijani Manat"),
            ("GEL", "₾", "Georgian Lari"),
            ("AMD", "֏", "Armenian Dram"),
            ("KGS", "с", "Kyrgyzstani Som"),
            ("TJS", "ЅМ", "Tajikistani Somoni"),
            ("TMT", "m", "Turkmenistan Manat"),
            ("MDL", "L", "Moldovan Leu"),
            ("BAM", "KM", "Bosnia-Herzegovina Convertible Mark"),
            ("MKD", "ден", "Macedonian Denar"),
            ("ALL", "L", "Albanian Lek"),
            ("ISK", "kr", "Icelandic Króna"),
            ("MNT", "₮", "Mongolian Tögrög"),
            ("NPR", "₨", "Nepalese Rupee"),
            ("PKR", "₨", "Pakistani Rupee"),
            ("BDT", "৳", "Bangladeshi Taka"),
            ("LKR", "රු", "Sri Lankan Rupee"),
            ("MMK", "K", "Myanmar Kyat"),
            ("KHR", "៛", "Cambodian Riel"),
            ("LAK", "₭", "Lao Kip"),
            ("MVR", ".ރ", "Maldivian Rufiyaa"),
            ("BND", "B$", "Brunei Dollar"),
            ("FJD", "FJ$", "Fijian Dollar"),
            ("PGK", "K", "Papua New Guinean Kina"),
            ("SBD", "SI$", "Solomon Islands Dollar"),
            ("TOP", "T$", "Tongan Paʻanga"),
            ("VUV", "VT", "Vanuatu Vatu"),
            ("WST", "WS$", "Samoan Tala"),
            ("XPF", "₣", "CFP Franc"),
            ("MOP", "MOP$", "Macanese Pataca"),
            ("HNL", "L", "Honduran Lempira"),
            ("GTQ", "Q", "Guatemalan Quetzal"),
            ("NIO", "C$", "Nicaraguan Córdoba"),
            ("DOP", "RD$", "Dominican Peso"),
            ("TTD", "TT$", "Trinidad & Tobago Dollar"),
            ("BBD", "Bds$", "Barbadian Dollar"),
            ("JMD", "J$", "Jamaican Dollar"),
            ("BSD", "B$", "Bahamian Dollar"),
            ("BZD", "BZ$", "Belize Dollar"),
            ("SRD", "$", "Surinamese Dollar"),
            ("GYD", "G$", "Guyanese Dollar"),
            ("HTG", "G", "Haitian Gourde"),
            ("CUP", "$", "Cuban Peso"),
            ("CUC", "CUC$", "Cuban Convertible Peso"),
            ("ANG", "ƒ", "Netherlands Antillean Guilder"),
            ("AWG", "ƒ", "Aruban Florin"),
            ("BMD", "BD$", "Bermudian Dollar"),
            ("KYD", "CI$", "Cayman Islands Dollar"),
            ("FKP", "£", "Falkland Islands Pound"),
            ("GIP", "£", "Gibraltar Pound"),
            ("SHP", "£", "Saint Helena Pound"),
            ("SSP", "£", "South Sudanese Pound"),
            ("SYP", "£", "Syrian Pound"),
            ("LBP", "ل.ل", "Lebanese Pound"),
            ("SDG", "ج.س.", "Sudanese Pound"),
            ("LYD", "ل.د", "Libyan Dinar"),
            ("TND", "د.ت", "Tunisian Dinar"),
            ("MGA", "Ar", "Malagasy Ariary"),
            ("MUR", "₨", "Mauritian Rupee"),
            ("SCR", "₨", "Seychellois Rupee"),
            ("DJF", "Fdj", "Djiboutian Franc"),
            ("RWF", "FRw", "Rwandan Franc"),
            ("BIF", "FBu", "Burundian Franc"),
            ("CDF", "FC", "Congolese Franc"),
            ("GNF", "FG", "Guinean Franc"),
            ("SLL", "Le", "Sierra Leonean Leone"),
            ("LRD", "L$", "Liberian Dollar"),
            ("GHS", "₵", "Ghanaian Cedi"),
            ("XAF", "FCFA", "Central African CFA Franc"),
            ("XOF", "CFA", "West African CFA Franc"),
            ("XAF", "FCFA", "Central African CFA Franc"),
            ("MRU", "UM", "Mauritanian Ouguiya"),
            ("STN", "Db", "São Tomé & Príncipe Dobra"),
            ("ERN", "Nfk", "Eritrean Nakfa"),
            ("SZL", "L", "Swazi Lilangeni"),
            ("LSL", "L", "Lesotho Loti"),
            ("NAD", "N$", "Namibian Dollar"),
            ("BWP", "P", "Botswanan Pula"),
            ("ZMW", "ZK", "Zambian Kwacha"),
            ("MWK", "MK", "Malawian Kwacha"),
            ("UGX", "USh", "Ugandan Shilling"),
            ("TZS", "TSh", "Tanzanian Shilling"),
            ("KES", "KSh", "Kenyan Shilling"),
            ("SOS", "Sh", "Somali Shilling"),
            ("ETB", "Br", "Ethiopian Birr")
        ]
    }
    
    private func checkIfCurrenciesExist() -> Bool {
        let descriptor = FetchDescriptor<Currency>()
        
        do {
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            print("Error checking currencies: \(error)")
            return false
        }
    }
    
}
