#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define ulli unsigned long long int 
#define STR_LIMIT 4096


long long int find_substring(char* string, char* substring) {
	if (strlen(string) < strlen(substring)) {
		return -1;
	}
	for (ulli i = 0; i < strlen(string); i++) {
		long long int tmp = i;
		if (string[i] == substring[0]) {
			for (ulli j = 1; j < strlen(substring); j++) {
				if (string[i + j] != substring[j]) {
					return -1;
				}
			}
			return tmp;
		}
	}
	return -1;
}


char* read_string_from_file(FILE *f) {
	char* ret = (char*) malloc(sizeof(char) * 134217728);
	char ch;
	ulli c = 0;
	while (c < 134217728 && (ch = fgetc(f)) != EOF) {
		if (ch > 127 || ch < 0) {
			return NULL;
		}
		ret[c++] = ch;
	}
	return ret;
}

char* get_rand_string(ulli size) {
	char* ret = (char*) malloc(sizeof(char) * size);
	char ch;
	ulli c = 0;
	while (c < size) {
		ret[c++] = (char) (rand() % 127);
	}
	return ret;
}

int main(int argc, char const *argv[])
{
	srand(time(NULL));
	clock_t start_read, end_read, start_calc, end_calc, start_write, end_write;
	if (argc < 2) {
		printf("Invalid args count\n");
		return 0;
	}
	if (strcmp(argv[1], "-f") == 0) {
		if (argc != 5) {
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
		start_read = clock();
		char* string = read_string_from_file(string_file);
		char* substring = read_string_from_file(substring_file);
		end_read = clock() - start_read;
		if (string == NULL || substring == NULL) {
			printf("Invalid chars in string. Must be in range [0-127].\n");
				free(string);
				free(substring);
				fclose(string_file);
				fclose(substring_file);
				return 0;
		}
		start_calc = clock();
		long long int position = find_substring(string, substring);
		end_calc = clock() - start_calc;
		start_write = clock();
		fprintf(out_file, "%lli\n", position);
		end_write = clock() - start_write;
		free(string);
		free(substring);
		fclose(string_file);
		fclose(substring_file);
		fclose(out_file);
		double time_read = ((double)end_read)/CLOCKS_PER_SEC;
		double time_calc = ((double)end_calc)/CLOCKS_PER_SEC;
		double time_write = ((double)end_write)/CLOCKS_PER_SEC;
		printf("Elapsed time:\n");
		printf("Read:\t\t%f\n", time_read);
		printf("Calculations:\t%f\n", time_calc);
		printf("Write:\t\t%f\n", time_write);

	} else if (strcmp(argv[1], "-r") == 0) {
		if (argc != 4) {
			printf("Invalid args count\n");
			return 0;
		}
		ulli n1 = atoll(argv[2]);
		ulli n2 = atoll(argv[3]);
		if (n1 >= STR_LIMIT || n2 >= STR_LIMIT) {
			printf("Length is greater than limit!\n");
			return 0;
		}
		char* string = get_rand_string(n1);
		char* substring = get_rand_string(n2);
		long long int position = find_substring(string, substring);
		printf("Generated string: %s\n", string);
		printf("Generated substring: %s\n", substring);
		printf("Posiniton of substring: %lli\n", position);
		free(string);
		free(substring);
 	} else {
		printf("Invalid flag\n");
	}
	return 0;
}