# paths to data files
REFERENCE=reference/NC_000913.3.fasta
READS=sample_data/

# paths to utilities
ALFRED_PATH = 'alfred_v0.1.2_linux_x86_64bit'

# paths to basecallers
NANOCALL_PATH = 'nanocall'
CHIRON_PATH = 'chiron'

# phony targets for running all benchmarks
.SECONDARY:
.PHONY : all nanocall chiron

all: nanocall chiron
nanocall: nanocall.alignment nanocall.kmer
chiron: chiron.alignment chiron.kmer

# basecalling (FAST5 => FASTA)
nanocall.fasta:
	$(NANOCALL_PATH) -t 8 --1d --pore r9 -o $@ $(READS)

chiron.fasta:
	$(NANOCALL_PATH) -t 8 -i $(READS) -o chiron
	python fastq_to_fasta.py chiron/result/
	cat chiron/result/*.fasta > chiron.fasta

# evaluation: k-mer distribution
%.kmer: %.fasta
	python kmer_distribution.py $< --k 5 > $@

# alignments (FASTA => SAM|BAM)
%.sam: %.fasta
	bwa mem -V -C -t 8 $(REFERENCE) $< > $@

%.bam: %.fasta
	bwa mem -x ont2d -t 8 $(REFERENCE) $< | samtools sort -o $@
	samtools index $@

# evaluation: alignment accuracy
%.alignment: %.bam
	$(ALFRED_PATH) qc -r $(REFERENCE) $< -o $(basename $@)
	date > $@
