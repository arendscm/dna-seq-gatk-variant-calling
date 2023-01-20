rule mutect2:
    input:
        fasta="resources/genome.fasta",
        map=get_sample_bams,
    output:
        vcf="results/mutect/{sample}.vcf"
    message:
        "Testing Mutect2 with {wildcards.sample}"
    threads: 1
    resources:
        mem_mb=1024,
    log:
        "logs/mutect_{sample}.log",
    wrapper:
        "v1.21.3/bio/gatk/mutect"
   
rule bgzip:
    input:
        "results/mutect/{sample}.vcf",
    output:
        "results/mutect/{sample}.vcf.gz",
    params:
        extra="", # optional
    threads: 1
    log:
        "logs/bgzip/{sample}.log",
    wrapper:
        "v1.21.3-3-gcb96cc40/bio/bgzip"

rule bcftools_merge:
    input:
        calls=expand("results/mutect/{sample}.vcf.gz", sample=samples.index),
    output:
        "results/mutect/all.vcf.gz",
    log:
        "logs/bcf-merge.log"
    params:
        uncompressed_bcf=False,
        extra="",  # optional parameters for bcftools concat (except -o)
    wrapper:
        "v1.21.4/bio/bcftools/merge"

