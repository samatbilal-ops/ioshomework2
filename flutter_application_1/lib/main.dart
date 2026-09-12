void main() {
  // ---------- TASK 1: Multiplication table ----------
  print("===== TASK 1: Multiplication table =====");
  printMultiplicationTable(3);

  // ---------- TASK 2: Next day ----------
  print("\n===== TASK 2: Next day =====");
  final task2Cases = [
    [5, 12, 2026],
    [28, 2, 2024],
    [28, 2, 2026],
    [29, 2, 2026], // invalid: 2026 is not a leap year
    [28, 2, 2100],
    [29, 2, 2000], // 2000 IS a leap year
    [31, 12, 2025],
  ];
  for (final c in task2Cases) {
    final result = nextDay(c[0], c[1], c[2]);
    print("${fmt(c[0], c[1], c[2])} -> $result");
  }

  // ---------- TASK 3: Vowel counter ----------
  print("\n===== TASK 3: Vowel counter =====");
  const phrase = "flutter mobile development";
  print("\"$phrase\" -> ${countVowels(phrase)}");

  // ---------- TASK 4: Manual min & max ----------
  print("\n===== TASK 4: Manual min & max =====");
  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];
  List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67];

  final minMax1 = findMinMax(numbers);
  final minMax2 = findMinMax(numbers1);
  print("numbers  -> max: ${minMax1['max']}, min: ${minMax1['min']}");
  print("numbers1 -> max: ${minMax2['max']}, min: ${minMax2['min']}");

  // ---------- TASK 5: Prime checker ----------
  print("\n===== TASK 5: Prime checker =====");
  for (final n in [3, 6, 1, 2, 17, 100, 97]) {
    print("$n -> ${isPrime(n) ? "prime number" : "not prime number"}");
  }
}

// ===================== TASK 1 =====================
void printMultiplicationTable(int digit) {
  print("MULTIPLICATION TABLE for digit $digit");
  for (int i = 1; i <= 10; i++) {
    print("$digit * $i = ${i * digit}");
  }
}

// ===================== TASK 2 =====================
bool isLeapYear(int year) {
  if (year % 400 == 0) return true;
  if (year % 100 == 0) return false;
  return year % 4 == 0;
}

int daysInMonth(int month, int year) {
  const daysNormal = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (month == 2 && isLeapYear(year)) return 29;
  return daysNormal[month - 1];
}

bool isValidDate(int day, int month, int year) {
  if (month < 1 || month > 12) return false;
  if (day < 1) return false;
  return day <= daysInMonth(month, year);
}

String nextDay(int day, int month, int year) {
  if (!isValidDate(day, month, year)) return "invalid date";

  int d = day + 1;
  int m = month;
  int y = year;

  if (d > daysInMonth(month, year)) {
    d = 1;
    m += 1;
    if (m > 12) {
      m = 1;
      y += 1;
    }
  }
  return fmt(d, m, y);
}

String fmt(int day, int month, int year) =>
    "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year";

// ===================== TASK 3 =====================
int countVowels(String text) {
  const vowels = "aeiouAEIOU";
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    if (vowels.contains(text[i])) count++;
  }
  return count;
}

// ===================== TASK 4 =====================
Map<String, int> findMinMax(List<int> list) {
  int max = list[0];
  int min = list[0];
  for (int i = 1; i < list.length; i++) {
    if (list[i] > max) max = list[i];
    if (list[i] < min) min = list[i];
  }
  return {"max": max, "min": min};
}

// ===================== TASK 5 =====================
bool isPrime(int n) {
  if (n < 2) return false;
  if (n == 2) return true;
  if (n % 2 == 0) return false;
  for (int i = 3; i * i <= n; i += 2) {
    if (n % i == 0) return false;
  }
  return true;
}