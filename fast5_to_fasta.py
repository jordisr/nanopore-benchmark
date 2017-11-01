'''
Extract FASTA reads from FAST5
'''

import h5py, sys, os, glob
from io import StringIO
from Bio import SeqIO

def fast5_to_fasta(fast5_file):
    hdf = h5py.File(fast5_file,'r')

    fastq_path = 'Analyses/Basecall_1D_000/BaseCalled_template/Fastq'
    fastq_string = hdf[fastq_path][()].decode('UTF-8')
    records = SeqIO.parse(StringIO(fastq_string), "fastq")
    SeqIO.write(records, sys.stdout, 'fasta')

    return None

if __name__ == '__main__':

    path = sys.argv[1]

    if os.path.isdir(path):
        for f in glob.glob(path+'/*.fast5'):
            fast5_to_fasta(f)
    else:
        fast5_to_fasta(path)
