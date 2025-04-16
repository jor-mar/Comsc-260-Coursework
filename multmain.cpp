// multmain.cpp - testing the AsmMultArray subroutine

#include <iostream>
#include <string>
#include "multarray.h"
using namespace std;

void printArr(long arr[], unsigned arrSize, string suffix) {
	string ret = "arr" + suffix + " = \t[";
	for (unsigned i = 0; i < arrSize - 1; i++) {
		ret += to_string(arr[i]) + ",\t";
	}
	ret += to_string(arr[arrSize - 1]) + "]\n";
	cout << ret;
}

int main() {
	const unsigned arrSize = 5; // array size
	const unsigned mval = 55; // number to multiply array entries by
	long test[] = {1, 3, 5, 7, 11}; // numbers in array
	// summarize testing preconditions
	cout << "Array multiplication value is " + to_string(mval) + ".\n";
	printArr(test, arrSize, "_before");
	// display results
	AsmMultArray(mval, test, arrSize);
	printArr(test, arrSize, "_after");
	return 0;
}