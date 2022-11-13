import sys
import random
import string

def get_random_string(length):
    result_str = ''.join(random.choice(string.ascii_letters) for i in range(length))
    return result_str

if (len(sys.argv) < 3):
    print('Usage: make-tests.py <string_length> <output_file>')
    exit()
n = int(sys.argv[1])
with open(sys.argv[2], 'wt') as f:
    f.write(f"{get_random_string(n)}\n")