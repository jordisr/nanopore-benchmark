'''
Count kmers in a FASTA file (all sequences pooled together).
'''

import numpy as np
from Bio import SeqIO
import argparse
import itertools

parser = argparse.ArgumentParser(description='Count K-mers in a sequence')
parser.add_argument('input', help='FASTA sequence to read')
parser.add_argument('--k', default=5, type=int, help='Length of k-mer')
args = parser.parse_args()

KMER_SIZE = args.k
ALPHABET = 'ACGT'
kmer_count = dict()

# initialize dictionary with all possible kmers
for kmer in itertools.product(ALPHABET, repeat=KMER_SIZE):
    kmer_string = ''.join(kmer)
    kmer_count[kmer_string] = 0

with open(args.input, 'rU') as handle:
    for record in SeqIO.parse(handle, "fasta"):
        i = 0
        while i < (len(record.seq)-KMER_SIZE):
            kmer_string = record.seq[i:i+KMER_SIZE]
            kmer_count[kmer_string] += 1
            i += 1

for key in sorted(kmer_count.keys()):
    print(key, kmer_count[key]/i)
