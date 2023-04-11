extension ExceptionalHandling on Object {
  void writeExceptionData() {
    try {

      // print the catched exception
      print(this.toString());
    } catch (error) {
      
      // prints the exception caught while printing the exception
      print(error.toString());
    }
  }
}