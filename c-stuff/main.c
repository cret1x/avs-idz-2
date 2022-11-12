#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define ulli unsigned long long int 


char* read_string_from_file(FILE *f) {
	char* ret = (char*) malloc(sizeof(char) * 134217728);
	char ch;
	ulli c = 0;
	while (c < 134217728 && (ch = fgetc(f)) != EOF) {
		if (ch > 127) {
			return NULL;
		}
		ret[c++] = ch;
	}
	return ret;
}

int main(int argc, char const *argv[])
{
	if (argc < 2) {
		printf("Invalid args count\n");
		return 0;
	}
	if (strcmp(argv[1], "-f") == 0) {
		if (argc < 5) {
			printf("Invalid args count\n");
			return 0;
		}
		FILE* string_file = fopen(argv[2], "r");
		FILE* substring_file = fopen(argv[3], "r");
		FILE* out_file = fopen(argv[4], "w");
		if (string_file == NULL || substring_file == NULL || out_file == NULL) {
			printf("Error opening the files\n");
			return 0;
		}
		char* string = read_string_from_file(string_file);
		char* substring = read_string_from_file(substring_file);
		if (string == NULL || substring == NULL) {
			printf("Invalid char over 127!!!\n");
				free(string);
				free(substring);
				fclose(string_file);
				fclose(substring_file);
				return 0;
		}
		char *fnd = strstr(string, substring);
		if (fnd) {
			ulli position = fnd - string;
			fprintf(out_file, "%llu\n", position);
		} else {
			fprintf(out_file, "-1\n");
		}
		free(string);
		free(substring);
		fclose(string_file);
		fclose(substring_file);
		fclose(out_file);

	} else if (strcmp(argv[1], "-r") == 0) {
		printf("Random mode\n");
	} else {
		printf("Invalid flag\n");
	}
	return 0;
}