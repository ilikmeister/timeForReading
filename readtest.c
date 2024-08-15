#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <inttypes.h>
#include <sys/time.h>

int64_t milliseconds(void) {
	struct timeval	now;
	
	gettimeofday(&now, NULL);
	return ((int64_t)now.tv_sec * 1000) + now.tv_usec / 1000;
}

void systemCalls (char file[], int size) {
	int64_t start_time = milliseconds();

	int fd = open(file, O_RDONLY);
	if (fd == -1) {
		fprintf(stderr, "cannot open '%s'\n", file);
		exit(EXIT_FAILURE);
	}

	char buffer[size];
	size_t got;

	while((got = read(fd, buffer, sizeof buffer)) > 0) {
		// just reading the file
	}

	close(fd);

	int64_t end_time = milliseconds();

	printf("%ld", end_time - start_time);
}

int main (int argc, char *argv[]) {
	if (argc != 3) {
		fprintf(stderr, "usage: %s file size\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	else {
		int size = atoi(argv[2]);
		systemCalls(argv[1], size);		
		EXIT_SUCCESS;
	}
	return 0;
}

