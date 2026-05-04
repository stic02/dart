//1. кружка

// class Kru {
//   int h2o = 50;
//   void pit(int ml){
//     h2o = (h2o - ml).clamp(0,50);
//   }  
// }

// class Chel {
//   void pit2(Kru k, int ml){
//     k.pit(ml);
//   } 
// }

// void main(){
//   Kru kruu = Kru();
//   Chel c = Chel();

//   c.pit2(kruu, 20);
//   print('осталось: ${kruu.h2o} мл');
// }


//2. шкаф
// class Shkaf {
//   List<String> veschi = [];
  
//   void polozhit(String v) {
//     veschi.add(v);
//   }
  
//   String vziat(int i) {
//     return veschi.removeAt(i);
//   }
// }

// void main() {
//   Shkaf s = Shkaf();
//   s.polozhit("книга");
//   s.polozhit("ручка");
//   print(s.vziat(0));
// }


//3. гриф и блин ?
// class Blin {
//   int ves;
//   Blin(this.ves);
// }

// class Grif {
//   int max;
//   int levo = 0;
//   int pravo = 0;
  
//   Grif(this.max);

//   bool addLeft(Blin b){
//     if (levo + pravo   max){

//     }
//   }


//4. конвектор
// class Converter {
//   double usd;
//   double eur;
  
//   Converter(this.usd, this.eur);
  
//   double ToUsd(double rub) {
//     return rub / usd;
//   }
  
//   double ToEur(double rub) {
//     return rub / eur;
//   }
// }

// void main() {
//   Converter c = Converter(78, 88);
//   print('1000 рублей = ${c.ToUsd(1000)} долларов');
//   print('1000 рублей = ${c.ToEur(1000)} евро');
// }


//5. гараж
// class Garazh {
//   List items = [];
  
//   void add(Object item) {
//     items.add(item);
//   }
  
//   Object get(int i) {
//     return items[i];
//   }
// }

// void main() {
//   Garazh g = Garazh();
//   g.add("машина");
//   g.add(123);
//   print(g.get(0));
// }


//6. перегрузка



//7. машина
// enum Sost{
//   stop,
//   go,
//   veer;
// }

// class Auto {
//   Sost sostt = Sost.stop;
  
//   void go() {
//     sostt = Sost.go;
//   }
  
//   void stop() {
//     sostt = Sost.stop;
//   }

//   void turn(){
//     sostt = Sost.veer;
//   }
// }

// void main() {
//   Auto a = Auto();
//   print(a.sostt);

//   a.go();
//   print(a.sostt);

//   a.turn();
//   print(a.sostt);
  
//   a.stop();
//   print(a.sostt);
// }

//8. фигуры
// class Pramoug {
//   double a, b;
//   Pramoug(this.a, this.b);
  
//   double square() {
//     return a * b;
//   }
// }

// class Krug {
//   double r;
//   Krug(this.r);
  
//   double square() {
//     return 3.14 * r * r;
//   }
// }

// void main() {
//   Pramoug p = Pramoug(5, 4);
//   Krug k = Krug(3);
//   print(p.square());
//   print(k.square());
// }


//9. системы счисления
// class Convector{
//   String Dec(int num, int toBase){
//     if(toBase == 16) {
//       return num.toRadixString(16);
//     } 
//       else if (toBase == 8) {
//       return num.toRadixString(8);
//     } 
//       else if (toBase == 2) {
//       return num.toRadixString(2);
//     } 
//       else {
//       return num.toString();
//     }
//   }

//  int Dec2(String num, int fromBase) {
//     return int.parse(num, radix: fromBase);
//   }
// }

// void main() {
//   Convector c = Convector();
//   print('255 в 16: ${c.Dec(255, 16)}');
//   print('255 в 8: ${c.Dec(255, 8)}');
//   print('255 в 2: ${c.Dec(255, 2)}');

//   print('FF в 16: ${c.Dec2("FF", 16)}');
//   print('376 в 8: ${c.Dec2("376", 8)}');
//   print('1101 в 2: ${c.Dec2("1101", 2)}');
// }

//10. макс площадь
// class Pramoug {
//   double a, b;
//   Pramoug(this.a, this.b);
//   double square() => a * b;
// }

// class Krug {
//   double r;
//   Krug(this.r);
//   double square() => 3.14 * r * r;
// }

// void main() {
//   List figury = [];
//   figury.add(Pramoug(5, 4));
//   figury.add(Krug(3));
//   figury.add(Pramoug(2, 10));
  
//   double max = 0;
//   for (var f in figury) {
//     double s = f.square();
//     if (s > max) max = s;
//   }
//   print(max);
// }


//11. стол
class Pribor {
  String name;
  Pribor(this.name);
}

class Nozh extends Pribor {
  Nozh() : super("нож");
}

class Vilka extends Pribor {
  Vilka() : super("вилка");
}


class Stol {
  Pribor? pribor;

  void postavit(Pribor p) {
    if (pribor == null) {
      pribor = p;
      print("поставили ${p.name} на стол");
    } else {
      print("уже на столе ${pribor!.name}, уберите его");
    }
  }

  void ubrat() {
    if (pribor != null) {
      print("убрали ${pribor!.name}");
      pribor = null;
    } else {
      print("на столе ничего нет");
    }
  }
}

void main() {
  Stol s = Stol();
  s.postavit(Nozh());
  s.ubrat();
  s.postavit(Vilka());
}