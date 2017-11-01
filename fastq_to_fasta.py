'''
Use biopython to convert FASTQ files in a directory to FASTA.
'''

from Bio import SeqIO
import sys, os, glob

def fastq_to_fasta(fastq):
    base = os.path.splitext(fastq)[0]
    print(fastq, base+'.fasta')
    SeqIO.convert(fastq, 'fastq', base+'.fasta', 'fasta')
    return None

if __name__ == '__main__':
    path = sys.argv[1]
    print("Looking in",path,'for FASTQ files...')
    if os.path.isdir(path):
        for f in glob.glob(path+'/*.fastq'):
            fastq_to_fasta(f)
    else:
        fastq_to_fasta(path)
