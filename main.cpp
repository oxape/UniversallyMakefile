#include <iostream>
#include "math/mathc.h"
#include "arithmetic/arithmeticc.h"

int main(int argc, char *argv[]) {
	int a = -3;
	int b = 11;

	int sum = Mathc::add(a, b);
	std::cout << a << " + " << b << " = " << sum << std::endl;

	int max = Arithmeticc::max(a, b);
	std::cout << "The largest numbers in " << a << " and " << b << " are " << max << std::endl;

	return 0;
}