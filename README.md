# RDDateAndTimes
dates, hours, minutes and second picker utility

MIT License

```swift
class ViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    
    let dateAndTimes = RDDateAndTimes(now: Date())
    @IBOutlet var picker:UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        RDDateAndTimes.Index.list().forEach {
            self.picker.selectRow(dateAndTimes.nowRow(index: $0) ?? 0,
                                  inComponent: $0.rawValue,
                                  animated: false)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return RDDateAndTimes.Index.count()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let index = RDDateAndTimes.Index(rawValue: component) else {
            fatalError()
        }
        return dateAndTimes.display(index: index).count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let index = RDDateAndTimes.Index(rawValue: component) else {
            fatalError()
        }
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.text = dateAndTimes.display(index: index)[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let list = RDDateAndTimes.Index.list().map {
            self.picker.selectedRow(inComponent: $0.rawValue)
        }
        guard let date = dateAndTimes.selectDate(indexList: list) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateS = dateFormatter.string(from: date)
        
        print("date = \(String(describing: dateS))")
    }

```
