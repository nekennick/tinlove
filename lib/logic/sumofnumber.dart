int getSumOfNumber(String name) {
  int number = 0;
  for (int i = 0; i < name.length; i++) {
    switch (name[i]) {
      case 'a':
      case 'k':
      case 'u':
        number += 1;
        break;
      case 'b':
      case 's':
      case 'j':
        number += 2;
        break;
      case 'c':
      case 'l':
      case 't':
        number += 3;
        break;
      case 'd':
      case 'n':
      case 'x':
        number += 4;
        break;
      case 'e':
      case 'm':
      case 'w':
        number += 5;
        break;
      case 'f':
      case 'o':
      case 'v':
        number += 6;
        break;
      case 'g':
      case 'q':
      case 'z':
        number += 7;
        break;
      case 'h':
      case 'p':
      case 'y':
        number += 8;
        break;
      case 'i':
      case 'r':
        number += 9;
        break;
    }
  }

  return number;
}
