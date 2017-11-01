# paths to data files
REFERENCE=reference/NC_000913.3.fasta
READS=sample_data/

# paths to utilities
ALFRED_PATH = 'alfred_v0.1.2_linux_x86_64bit'

# paths to basecallers
NANOCALL_PATH = 'nanocall'

# phony targets for running all benchmarks
.SECONDARY:
.PHONY : all
all: nanocall.alignment nanocall.kmer

.PHONY : clean
clean:
	rm nanocall.*

# basecalling (FAST5 => FASTA)
nanocall.fasta:
	$(NANOCALL_PATH) -t 8 --1d --pore r9 -o $@ $(READS)

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
