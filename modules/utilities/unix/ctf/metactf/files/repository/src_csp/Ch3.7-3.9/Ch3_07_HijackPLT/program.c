#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void printflag();

char msg[] =
 "(From overthewire.org) When pointers are corrupted from format string\n"
 "vulnerabilities and heap overflows, an adversary can inject arbitrary\n"
 "input into critical parts of a process's memory.  One such area for\n"
 "corruption is the procedure link table: a table of function pointers\n"
 "that support dynamically linked library calls.  The table is filled in at\n"
 "load time to support run-time code relocation and is often left writeable.\n"
 "In this level, you are allowed one arbrtrary write to an arbitrary memory\n"
 "location between 0x0 and 0xff000000 to unlock the program.  We have added\n"
 "a call to sleep() that you may hijack. To do so, use objdump\" or \"gdb\"\n"
 "to find its PLT entry, the memory location to overwrite and the address of\n"
 "the function to execute instead.  We have included the source code for you\n"
 "to peruse. Note that the password will be read in using:\n"
 "  scanf(\"%lx \%lx\");\n\n";

void print_good() {
	printf("Good Job.\n");
    printflag();
    exit(0);
}
void segv_handler(int sig) {
    printf("Segmentation fault.  Try again.\n");
    exit(0);
}
void ill_handler(int sig) {
    printf("Illegal instruction hit.  Try again.\n");
    exit(0);
}
void print_msg() {
    printf("%s",msg);
}
void printflag()
{
	int fd;
	int len;
	unsigned char data[128];

	fd = open("flag", O_RDONLY);

	if ( fd <= 0 ) {
		printf("Failed to open flag.\n");
		return;
	}

	len = lseek( fd, 0, SEEK_END);
	lseek(fd, 0, SEEK_SET);

	if ( len > 128 ) {
		len = 128;
	}

	memset(data, 0, 128);
	read( fd, data, len);
	close(fd);

	printf("%s\n", data);
	return;
}
int main()
{
    unsigned long int *ip;
    unsigned long int i;

    signal(SIGSEGV, segv_handler);
    signal(SIGILL, ill_handler);

    print_msg();
    printf("The password is a hexadecimal address and a hexadecimal value\n");
    printf("to place at that address.\n");
    printf("Enter the password: ");
    scanf("%lx %lx",(unsigned long int *) &ip,&i);
    if (ip > (unsigned long int *) 0xff000000) {
	printf("Address too high.  Try again.\n");
	exit(0);
    }
    *ip = i;
    printf("The address: %lx will now contain %lx\n",(unsigned long int) ip,i);
    sleep(1);
    printf("Try again.\n");
    exit(0);
}
