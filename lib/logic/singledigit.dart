int getSingleDigit(int number) {
  while (number >= 10) {
    int sum = 0;
    while (number > 0) {
      sum += number % 10;
      number ~/= 10;
    }
    number = sum;
  }
  return number;
}
