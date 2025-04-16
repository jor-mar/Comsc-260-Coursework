// summain.cpp - testing the AsmSumThreeArrays subroutine

#include <iostream>
#include <string>
#include "addarr.h"
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
	const unsigned arr_size = 5; // array size
	long arr1[arr_size], arr2[arr_size], arr3[arr_size]; // instantiate arrays

	// populate arr1, arr2, and arr3 with pseudorandom numbers
	for (unsigned i = 0; i < arr_size; i++) {
		arr1[i] = rand();
		arr2[i] = rand();
		arr3[i] = rand();
	}

	//display each array
	printArr(arr1, arr_size, "1");
	printArr(arr2, arr_size, "2");
	printArr(arr3, arr_size, "3");
	cout << "\n";

	// display end result:
	// arr1[i] = arr1[i] + arr2[i] + arr3[i]
	// arr2 and arr3 are unchanged
	AsmSumThreeArrays(arr1, arr2, arr3, arr_size);
	printArr(arr1, arr_size, "1");
	printArr(arr2, arr_size, "2");
	printArr(arr3, arr_size, "3");
	return 0;
}