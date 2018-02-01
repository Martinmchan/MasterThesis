#include <stdio.h>
#include <stdlib.h>

int main() {

	system("arecord -Daudiosource -r48000 -fS16_LE -c1 viaC.wav &");
	system("aplay -Dlocalhw_0 -r48000 -d1 -fS16_LE /dev/urandom &");

	system("^C");
		
	
	return 0;
}
