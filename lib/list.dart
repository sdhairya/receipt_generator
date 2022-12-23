

class receiptData {
  String itemName = "";
  int quantity = 0;
  double price = 0.0;

  receiptData(
      {required this.itemName, required this.quantity, required this.price});

  @override
  String toString() {
    return "$itemName\n$quantity\n$price";
  }
}