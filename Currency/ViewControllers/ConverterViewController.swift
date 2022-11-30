//
//  ConverterViewController.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

class ConverterViewController: UIViewController {
    
    var currencyConnverterViewModel : CurrencyConversionViewModel?
    let fromCurrencyTextField = CurrencyAmountTextField.init()
    let toCurrencyTextField = CurrencyAmountTextField.init()
    let swapButton = UIButton(type: .custom)
    var currentPickingField: TextFieldType?
    let detailsButton: UIButton = .init(type: .custom)
    
    override func loadView() {
        super.loadView()
        
        currencyConnverterViewModel = CurrencyConversionViewModel(subscriber: self)
        view = UIView()
        view.backgroundColor = .white
        
        setupConverterFields()
        setupSubviewsAndConstraints()
        
    }
    
    private func setupSubviewsAndConstraints() {
        view.addSubview(swapButton)
        view.addSubview(fromCurrencyTextField)
        view.addSubview(toCurrencyTextField)
        view.addSubview(detailsButton)
        view.addConstraints([swapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), swapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).with(0.3)])
        view.addConstraints([fromCurrencyTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8), fromCurrencyTextField.trailingAnchor.constraint(equalTo: swapButton.leadingAnchor, constant: -20), fromCurrencyTextField.centerYAnchor.constraint(equalTo: swapButton.centerYAnchor), toCurrencyTextField.leadingAnchor.constraint(equalTo: swapButton.trailingAnchor, constant: 20), toCurrencyTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8), toCurrencyTextField.centerYAnchor.constraint(equalTo: swapButton.centerYAnchor)])
        view.addConstraints([detailsButton.centerXAnchor.constraint(equalTo: swapButton.centerXAnchor), detailsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), detailsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                             detailsButton.centerYAnchor.constraint(equalTo: swapButton.centerYAnchor, constant: 100)])
    }
    
    private func setupConverterFields() {
        fromCurrencyTextField.textFieldType = .from
        fromCurrencyTextField.delegate = self
        toCurrencyTextField.textFieldType = .to
        toCurrencyTextField.delegate = self
        swapButton.setImage(.init(named: "swap"), for: .normal)
        swapButton.frame = .init(origin: .zero, size: .init(width: 32, height: 32))
        swapButton.addTarget(self, action: #selector(swapCurrency), for: .touchUpInside)
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyTextField.pickerActionHanlder = self
        toCurrencyTextField.pickerActionHanlder = self
        toCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        detailsButton.backgroundColor = .blue.withAlphaComponent(0.7)
    }
    let MOCK = true
    @objc private func showDetails() {
        if MOCK {
            let inputCurrencies = """
{
  "currencies": {
    "AED": "United Arab Emirates Dirham",
    "AFN": "Afghan Afghani",
    "ALL": "Albanian Lek",
    "AMD": "Armenian Dram",
    "ANG": "Netherlands Antillean Guilder",
    "AOA": "Angolan Kwanza",
    "ARS": "Argentine Peso",
    "AUD": "Australian Dollar",
    "AWG": "Aruban Florin",
    "AZN": "Azerbaijani Manat",
    "BAM": "Bosnia-Herzegovina Convertible Mark",
    "BBD": "Barbadian Dollar",
    "BDT": "Bangladeshi Taka",
    "BGN": "Bulgarian Lev",
    "BHD": "Bahraini Dinar",
    "BIF": "Burundian Franc",
    "BMD": "Bermudan Dollar",
    "BND": "Brunei Dollar",
    "BOB": "Bolivian Boliviano",
    "BRL": "Brazilian Real",
    "BSD": "Bahamian Dollar",
    "BTC": "Bitcoin",
    "BTN": "Bhutanese Ngultrum",
    "BWP": "Botswanan Pula",
    "BYN": "New Belarusian Ruble",
    "BYR": "Belarusian Ruble",
    "BZD": "Belize Dollar",
    "CAD": "Canadian Dollar",
    "CDF": "Congolese Franc",
    "CHF": "Swiss Franc",
    "CLF": "Chilean Unit of Account (UF)",
    "CLP": "Chilean Peso",
    "CNY": "Chinese Yuan",
    "COP": "Colombian Peso",
    "CRC": "Costa Rican Coln",
    "CUC": "Cuban Convertible Peso",
    "CUP": "Cuban Peso",
    "CVE": "Cape Verdean Escudo",
    "CZK": "Czech Republic Koruna",
    "DJF": "Djiboutian Franc",
    "DKK": "Danish Krone",
    "DOP": "Dominican Peso",
    "DZD": "Algerian Dinar",
    "EGP": "Egyptian Pound",
    "ERN": "Eritrean Nakfa",
    "ETB": "Ethiopian Birr",
    "EUR": "Euro",
    "FJD": "Fijian Dollar",
    "FKP": "Falkland Islands Pound",
    "GBP": "British Pound Sterling",
    "GEL": "Georgian Lari",
    "GGP": "Guernsey Pound",
    "GHS": "Ghanaian Cedi",
    "GIP": "Gibraltar Pound",
    "GMD": "Gambian Dalasi",
    "GNF": "Guinean Franc",
    "GTQ": "Guatemalan Quetzal",
    "GYD": "Guyanaese Dollar",
    "HKD": "Hong Kong Dollar",
    "HNL": "Honduran Lempira",
    "HRK": "Croatian Kuna",
    "HTG": "Haitian Gourde",
    "HUF": "Hungarian Forint",
    "IDR": "Indonesian Rupiah",
    "ILS": "Israeli New Sheqel",
    "IMP": "Manx pound",
    "INR": "Indian Rupee",
    "IQD": "Iraqi Dinar",
    "IRR": "Iranian Rial",
    "ISK": "Icelandic Krna",
    "JEP": "Jersey Pound",
    "JMD": "Jamaican Dollar",
    "JOD": "Jordanian Dinar",
    "JPY": "Japanese Yen",
    "KES": "Kenyan Shilling",
    "KGS": "Kyrgystani Som",
    "KHR": "Cambodian Riel",
    "KMF": "Comorian Franc",
    "KPW": "North Korean Won",
    "KRW": "South Korean Won",
    "KWD": "Kuwaiti Dinar",
    "KYD": "Cayman Islands Dollar",
    "KZT": "Kazakhstani Tenge",
    "LAK": "Laotian Kip",
    "LBP": "Lebanese Pound",
    "LKR": "Sri Lankan Rupee",
    "LRD": "Liberian Dollar",
    "LSL": "Lesotho Loti",
    "LTL": "Lithuanian Litas",
    "LVL": "Latvian Lats",
    "LYD": "Libyan Dinar",
    "MAD": "Moroccan Dirham",
    "MDL": "Moldovan Leu",
    "MGA": "Malagasy Ariary",
    "MKD": "Macedonian Denar",
    "MMK": "Myanma Kyat",
    "MNT": "Mongolian Tugrik",
    "MOP": "Macanese Pataca",
    "MRO": "Mauritanian Ouguiya",
    "MUR": "Mauritian Rupee",
    "MVR": "Maldivian Rufiyaa",
    "MWK": "Malawian Kwacha",
    "MXN": "Mexican Peso",
    "MYR": "Malaysian Ringgit",
    "MZN": "Mozambican Metical",
    "NAD": "Namibian Dollar",
    "NGN": "Nigerian Naira",
    "NIO": "Nicaraguan C\\u00f3rdoba",
    "NOK": "Norwegian Krone",
    "NPR": "Nepalese Rupee",
    "NZD": "New Zealand Dollar",
    "OMR": "Omani Rial",
    "PAB": "Panamanian Balboa",
    "PEN": "Peruvian Nuevo Sol",
    "PGK": "Papua New Guinean Kina",
    "PHP": "Philippine Peso",
    "PKR": "Pakistani Rupee",
    "PLN": "Polish Zloty",
    "PYG": "Paraguayan Guarani",
    "QAR": "Qatari Rial",
    "RON": "Romanian Leu",
    "RSD": "Serbian Dinar",
    "RUB": "Russian Ruble",
    "RWF": "Rwandan Franc",
    "SAR": "Saudi Riyal",
    "SBD": "Solomon Islands Dollar",
    "SCR": "Seychellois Rupee",
    "SDG": "Sudanese Pound",
    "SEK": "Swedish Krona",
    "SGD": "Singapore Dollar",
    "SHP": "Saint Helena Pound",
    "SLE": "Sierra Leonean Leone",
    "SLL": "Sierra Leonean Leone",
    "SOS": "Somali Shilling",
    "SRD": "Surinamese Dollar",
    "STD": "S Tom and Predncipe Dobra",
    "SVC": "Salvadoran Coln",
    "SYP": "Syrian Pound",
    "SZL": "Swazi Lilangeni",
    "THB": "Thai Baht",
    "TJS": "Tajikistani Somoni",
    "TMT": "Turkmenistani Manat",
    "TND": "Tunisian Dinar",
    "TOP": "Tongan Pabbanga",
    "TRY": "Turkish Lira",
    "TTD": "Trinidad and Tobago Dollar",
    "TWD": "New Taiwan Dollar",
    "TZS": "Tanzanian Shilling",
    "UAH": "Ukrainian Hryvnia",
    "UGX": "Ugandan Shilling",
    "USD": "United States Dollar",
    "UYU": "Uruguayan Peso",
    "UZS": "Uzbekistan Som",
    "VEF": "Venezuelan Boledvar Fuerte",
    "VES": "Sovereign Bolivar",
    "VND": "Vietnamese Dong",
    "VUV": "Vanuatu Vatu",
    "WST": "Samoan Tala",
    "XAF": "CFA Franc BEAC",
    "XAG": "Silver (troy ounce)",
    "XAU": "Gold (troy ounce)",
    "XCD": "East Caribbean Dollar",
    "XDR": "Special Drawing Rights",
    "XOF": "CFA Franc BCEAO",
    "XPF": "CFP Franc",
    "YER": "Yemeni Rial",
    "ZAR": "South African Rand",
    "ZMK": "Zambian Kwacha (pre-2013)",
    "ZMW": "Zambian Kwacha",
    "ZWL": "Zimbabwean Dollar"
  },
  "success": true
}
"""
            let r = try! JSONDecoder().decode(SupportedCurrencies.self, from: inputCurrencies.data(using: .utf8)!)
            currencyConnverterViewModel?.currencies = r.currencies
            currencyConnverterViewModel?.fromCurrency = ["AED": r.currencies["AED"]!]
            currencyConnverterViewModel?.toCurrency = ["AUD": r.currencies["AUD"]!]
            
            let rates = """
{
  "quotes": {
    "AEDAFN": 24.272288,
    "AEDALL": 30.663333,
    "AEDAMD": 108.039465,
    "AEDANG": 0.492351,
    "AEDAOA": 138.050079,
    "AEDARS": 45.457163,
    "AEDAUD": 0.404924,
    "AEDAWG": 0.490059,
    "AEDAZN": 0.462842,
    "AEDBAM": 0.514587,
    "AEDBBD": 0.551566,
    "AEDBDT": 27.751111,
    "AEDBGN": 0.513699,
    "AEDBHD": 0.102638,
    "AEDBIF": 565.595616,
    "AEDBMD": 0.272255,
    "AEDBND": 0.374648,
    "AEDBOB": 1.887633,
    "AEDBRL": 1.435109,
    "AEDBSD": 0.273192,
    "AEDBTC": 1.6125844e-05,
    "AEDBTN": 22.302626,
    "AEDBWP": 3.506905,
    "AEDBYN": 0.689807,
    "AEDBYR": 5336.194486,
    "AEDBZD": 0.550645,
    "AEDCAD": 0.368779,
    "AEDCDF": 558.666827,
    "AEDCHF": 0.258566,
    "AEDCLF": 0.00889,
    "AEDCLP": 245.315104,
    "AEDCNY": 1.928658,
    "AEDCOP": 1309.842445,
    "AEDCRC": 163.648109,
    "AEDCUC": 0.272255,
    "AEDCUP": 7.214753,
    "AEDCVE": 29.01145,
    "AEDCZK": 6.399377,
    "AEDDJF": 48.631404,
    "AEDDKK": 1.95348,
    "AEDDOP": 14.914248,
    "AEDDZD": 37.745141,
    "AEDEGP": 6.696843,
    "AEDERN": 4.083822,
    "AEDETB": 14.598587,
    "AEDEUR": 0.262692,
    "AEDFJD": 0.603834,
    "AEDFKP": 0.22699,
    "AEDGBP": 0.226935,
    "AEDGEL": 0.736461,
    "AEDGGP": 0.22699,
    "AEDGHS": 3.933654,
    "AEDGIP": 0.22699,
    "AEDGMD": 16.86612,
    "AEDGNF": 2356.087006,
    "AEDGTQ": 2.134821,
    "AEDGYD": 57.152017,
    "AEDHKD": 2.123888,
    "AEDHNL": 6.746314,
    "AEDHRK": 1.983702,
    "AEDHTG": 38.382267,
    "AEDHUF": 106.97463,
    "AEDIDR": 4269.976544,
    "AEDILS": 0.935854,
    "AEDIMP": 0.22699,
    "AEDINR": 22.153238,
    "AEDIQD": 398.712079,
    "AEDIRR": 11543.604428,
    "AEDISK": 38.641226,
    "AEDJEP": 0.22699,
    "AEDJMD": 42.078161,
    "AEDJOD": 0.193273,
    "AEDJPY": 37.826268,
    "AEDKES": 33.364884,
    "AEDKGS": 22.991429,
    "AEDKHR": 1129.32351,
    "AEDKMF": 129.457378,
    "AEDKPW": 245.003402,
    "AEDKRW": 358.001377,
    "AEDKWD": 0.0838,
    "AEDKYD": 0.227648,
    "AEDKZT": 127.810987,
    "AEDLAK": 4741.838772,
    "AEDLBP": 413.099325,
    "AEDLKR": 100.390167,
    "AEDLRD": 41.927161,
    "AEDLSL": 4.628308,
    "AEDLTL": 0.803898,
    "AEDLVL": 0.164684,
    "AEDLYD": 1.336778,
    "AEDMAD": 2.921473,
    "AEDMDL": 5.298203,
    "AEDMGA": 1191.782022,
    "AEDMKD": 16.211705,
    "AEDMMK": 573.674591,
    "AEDMNT": 932.415109,
    "AEDMOP": 2.197803,
    "AEDMRO": 97.194924,
    "AEDMUR": 12.073134,
    "AEDMVR": 4.183204,
    "AEDMWK": 280.398403,
    "AEDMXN": 5.246923,
    "AEDMYR": 1.210854,
    "AEDMZN": 17.378037,
    "AEDNAD": 4.628433,
    "AEDNGN": 120.864719,
    "AEDNIO": 9.833105,
    "AEDNOK": 2.702491,
    "AEDNPR": 35.685131,
    "AEDNZD": 0.436597,
    "AEDOMR": 0.104679,
    "AEDPAB": 0.273161,
    "AEDPEN": 1.050864,
    "AEDPGK": 0.962577,
    "AEDPHP": 15.398999,
    "AEDPKR": 61.362686,
    "AEDPLN": 1.226261,
    "AEDPYG": 1975.672147,
    "AEDQAR": 0.991415,
    "AEDRON": 1.293592,
    "AEDRSD": 30.824934,
    "AEDRUB": 16.557186,
    "AEDRWF": 295.494947,
    "AEDSAR": 1.023492,
    "AEDSBD": 2.237136,
    "AEDSCR": 3.523301,
    "AEDSDG": 155.048506,
    "AEDSEK": 2.870915,
    "AEDSGD": 0.372381,
    "AEDSHP": 0.375004,
    "AEDSLE": 4.984684,
    "AEDSLL": 4980.90202,
    "AEDSOS": 154.776121,
    "AEDSRD": 8.517779,
    "AEDSTD": 5635.125109,
    "AEDSVC": 2.390141,
    "AEDSYP": 684.00733,
    "AEDSZL": 4.627311,
    "AEDTHB": 9.596846,
    "AEDTJS": 2.745373,
    "AEDTMT": 0.955614,
    "AEDTND": 0.885509,
    "AEDTOP": 0.643284,
    "AEDTRY": 5.074177,
    "AEDTTD": 1.851165,
    "AEDTWD": 8.410006,
    "AEDTZS": 635.44273,
    "AEDUAH": 10.040042,
    "AEDUGX": 1021.11673,
    "AEDUSD": 0.272255,
    "AEDUYU": 10.728854,
    "AEDUZS": 3063.082483,
    "AEDVEF": 293571.14396,
    "AEDVES": 2.938351,
    "AEDVND": 6709.720057,
    "AEDVUV": 32.440085,
    "AEDWST": 0.744501,
    "AEDXAF": 172.595792,
    "AEDXAG": 0.012667,
    "AEDXAU": 0.000155,
    "AEDXCD": 0.735782,
    "AEDXDR": 0.20742,
    "AEDXOF": 172.591622,
    "AEDXPF": 31.513537,
    "AEDYER": 68.13183,
    "AEDZAR": 4.615019,
    "AEDZMK": 2450.619987,
    "AEDZMW": 4.638572,
    "AEDZWL": 87.665941
  },
  "source": "AED",
  "success": true,
  "timestamp": 1669805523
}
"""
            
            let currRates = try! JSONDecoder().decode(ExchangeRate.self, from: rates.data(using: .utf8)!)
            currencyConnverterViewModel?.currencyRate = currRates.quotes
            
            let historyRate = """
            {
              "date": "2022-11-30",
              "historical": true,
              "quotes": {
                "AEDUSD": 0.272255
              },
              "source": "AED",
              "success": true,
              "timestamp": 1669807263
            }
"""
            let historyRate2 = """
            {
              "date": "2022-11-29",
              "historical": true,
              "quotes": {
                "AEDUSD": 0.2844
              },
              "source": "AED",
              "success": true,
              "timestamp": 1669797263
            }
"""
            currencyConnverterViewModel?.historicalRate.append(try! JSONDecoder().decode(RateHistory.self, from: historyRate.data(using: .utf8)!))
            currencyConnverterViewModel?.historicalRate.append(try! JSONDecoder().decode(RateHistory.self, from: historyRate2.data(using: .utf8)!))
        }
        
        let historyController = HistoricalRateAndPopularCurrencyController(model: currencyConnverterViewModel!, popularCurrencies: [])
        navigationController?.pushViewController(historyController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Converter"
    }
    
    @objc func swapCurrency() {
        currencyConnverterViewModel?.swapCurrencies()
        if let fromAmount = fromCurrencyTextField.text {
            currencyConnverterViewModel?.fromTextFieldAmount = fromAmount
        } else if let toAmount = toCurrencyTextField.text {
            currencyConnverterViewModel?.toTextFieldAmount = toAmount
        }
    }
}


extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currencyAmountTextField = textField as? CurrencyAmountTextField else {
            return true
        }
        let fieldText = textField.text ?? ""
        let resultantText = string == "" ? String(fieldText.dropLast(1)) : fieldText + string
       
        switch currencyAmountTextField.textFieldType {
            case .from:
                currencyConnverterViewModel?.fromTextFieldAmount = resultantText
                break
            case .to:
                currencyConnverterViewModel?.toTextFieldAmount = resultantText
                break
        }
        return true
    }
    
}


extension ConverterViewController : CurrencyConversionViewModelEventable {
    func dataFetchError(msg: String?) {
        DispatchQueue.main.async { [weak self] in 
            self?.showErrorMessage(message: msg ?? "Something unexpected happened!")
        }
    }
    
    func dataFetchStarted() {
        fromCurrencyTextField.isEnabled = false
        toCurrencyTextField.isEnabled = false
        swapButton.isEnabled = false
    }
    
    func dateFetchCompleted() {
        fromCurrencyTextField.isEnabled = true
        toCurrencyTextField.isEnabled = true
        swapButton.isEnabled = true
    }
    
    func updateDisplayedData() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        (fromCurrencyTextField.leftView as? UIButton)?.setTitle(model.fromCurrency?.keys.first ?? "_\u{25BE}", for: .normal)
        (toCurrencyTextField.leftView as? UIButton)?.setTitle(model.toCurrency?.keys.first ??  "_\u{25BE}", for: .normal)
    }
    
    func updateFromfield() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        fromCurrencyTextField.text = model.fromTextFieldAmountDisplayable
    }
    func updateToField() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        toCurrencyTextField.text = model.toTextFieldAmountDisplayable
    }
}

extension ConverterViewController : CurrencyPickable, CurrencyPickedHandler {
    func pickCurrency(for type: TextFieldType) {
        currentPickingField = type
        let picker = PickerController(style: .insetGrouped)
        picker.data = currencyConnverterViewModel?.currencies
        picker.currencyPickedHandler = self
        present(picker, animated: true)
    }
    
    func currencyPicked(picked: [String : String]) {
        switch currentPickingField {
        case .to:
            currencyConnverterViewModel?.toCurrency = picked
            break
        case .from:
            currencyConnverterViewModel?.fromCurrency = picked
            break
        default:
            //No cases - impossible
            break
        }
        dismiss(animated: true)
    }
}
