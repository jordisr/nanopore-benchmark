# Benchmark basecallers for nanopore sequencing

### Description
Assess accuracy of available basecallers. Planning on adding support for many of the following:
DeepNano, BasecRAWller, Nanonet/Albacore/Scrappie

Basecallers initially included for testing:
* Nanocall (https://github.com/mateidavid/nanocall)
* Chiron (https://github.com/haotianteng/Chiron)
* Metrichor (original basecaller from ONT)

### Requirements
* Python 3 and Biopython
* BWA (https://github.com/lh3/bwa), for reference genome alignment
* Alfred (https://github.com/tobiasrausch/alfred), for gathering alignment statistics
* Japsa (https://github.com/mdcao/japsa), for gathering alignment statistics
