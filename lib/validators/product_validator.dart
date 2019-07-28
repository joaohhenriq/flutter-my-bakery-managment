class ProductValidator {

  String validateImages(List images){
    if(images.isEmpty) return "Add some images for the product";
    return null;
  }

  String validateTitle(String text) {
    if (text.isEmpty) return "Title is empty!";
    return null;
  }

  String validateDescription(String text) {
    if (text.isEmpty) return "Description is empty";
    return null;
  }

  String validatePrice(String text) {
    double price = double.tryParse(text);
    if (price != null) {
      //text.split(".")[1].length != 2 quebra o texto no ponto, pega a segunda parte do texto e verifica se o tamanho é 2
      if (!text.contains(".") || text.split(".")[1].length != 2) {
        return "Use 2 decimal places";
      }
    } else {
      return "Price is invalid";
    }
    return null;
  }
}
