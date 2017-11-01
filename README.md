# Benchmark basecallers for nanopore sequencing

### Description
Compare PoreOver to other available basecallers.

Planning on adding support for many of the following basecallers:
DeepNano, BasecRAWller, Chiron, Nanocall, Nanonet/Albacore/Scrappie

Basecallers currently included for testing:
* Nanocall (https://github.com/mateidavid/nanocall)
* Chiron (https://github.com/haotianteng/Chiron)
* Metrichor (default basecaller from ONT)

### Requirements
* Python 3 and Biopython
* BWA, for reference genome alignment
* Alfred, for gathering alignment statistics
* Japsa, for gathering alignment statistics
