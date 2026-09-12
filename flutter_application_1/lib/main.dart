// Homework 2: Safe ATM Banking Terminal Simulator
// Demonstrates: functions, named parameters, arrow syntax (=>), and
// Sound Null Safety operators (?, ??, !)

// -----------------------------------------------------------------------
// 1. checkBalance
//    - Arrow function
//    - name: required String, balance: required double
// -----------------------------------------------------------------------
void checkBalance({required String name, required double balance}) =>
    print('[$name] Current available balance: \$${balance.toStringAsFixed(2)}');

// -----------------------------------------------------------------------
// 2. deposit
//    - currentBalance: required double
//    - amount: optional, nullable double (double?)
//    - Uses ?? to default a null amount to 0.0
// -----------------------------------------------------------------------
double deposit({required double currentBalance, double? amount}) {
  // Safely unpack amount, defaulting to 0.0 if null
  final double depositAmount = amount ?? 0.0;

  final double updatedBalance = currentBalance + depositAmount;

  print('Receipt: Deposited \$${depositAmount.toStringAsFixed(2)} | '
      'New balance: \$${updatedBalance.toStringAsFixed(2)}');

  return updatedBalance;
}

// -----------------------------------------------------------------------
// 3. withdraw
//    - name: required String
//    - currentBalance: required double
//    - amount: optional, nullable double
//    - pinCode: optional, nullable int
//    - Uses ?? for PIN default and amount default
// -----------------------------------------------------------------------
double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  const int correctPin = 1234;

  // If pinCode is null or missing, fall back to an invalid default (0000)
  final int enteredPin = pinCode ?? 0000;

  if (enteredPin != correctPin) {
    print('Transaction Declined for $name: Incorrect PIN.');
    return currentBalance;
  }

  // Safely unpack amount, defaulting to 0.0 if null
  final double withdrawAmount = amount ?? 0.0;

  if (withdrawAmount > currentBalance) {
    print('Transaction Declined for $name: Insufficient funds '
        '(requested \$${withdrawAmount.toStringAsFixed(2)}, '
        'available \$${currentBalance.toStringAsFixed(2)}).');
    return currentBalance;
  }

  final double updatedBalance = currentBalance - withdrawAmount;

  print('Transaction Successful for $name: Withdrew '
      '\$${withdrawAmount.toStringAsFixed(2)} | '
      'New balance: \$${updatedBalance.toStringAsFixed(2)}');

  return updatedBalance;
}

// -----------------------------------------------------------------------
// main: demonstrates all three functions, including the null-assertion (!)
// operator when we are certain a nullable value is safe to unwrap.
// -----------------------------------------------------------------------
void main() {
  const String user = 'Alice';
  double balance = 500.0;

  print('--- ATM Session Start ---');
  checkBalance(name: user, balance: balance);

  // Deposit with a valid amount
  balance = deposit(currentBalance: balance, amount: 150.0);

  // Deposit with a null amount -> defaults to 0.0 via ??
  double? missingDeposit;
  balance = deposit(currentBalance: balance, amount: missingDeposit);

  checkBalance(name: user, balance: balance);

  // Withdraw with wrong PIN -> declined
  balance = withdraw(
    name: user,
    currentBalance: balance,
    amount: 100.0,
    pinCode: 4321,
  );

  // Withdraw with amount exceeding balance -> declined
  balance = withdraw(
    name: user,
    currentBalance: balance,
    amount: 999999.0,
    pinCode: 1234,
  );

  // Withdraw with a stored nullable PIN we are CONFIDENT is set.
  // The null-assertion operator (!) unwraps it, since we've already
  // checked it is not null.
  int? storedPin = 1234;
  if (storedPin != null) {
    balance = withdraw(
      name: user,
      currentBalance: balance,
      amount: 200.0,
      pinCode: storedPin!, // safe unwrap: guarded by the null check above
    );
  }

  // Withdraw with no PIN provided at all -> defaults to 0000 -> declined
  balance = withdraw(
    name: user,
    currentBalance: balance,
    amount: 50.0,
  );

  print('--- Final Balance ---');
  checkBalance(name: user, balance: balance);
  print('--- ATM Session End ---');
}