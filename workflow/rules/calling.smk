rule mutect2:
    input:
        fasta="resources/genome.fasta",
        map=get_sample_bams,
    output:
        vcf="results/mutect/{sample}.vcf.gz"
    message:
        "Testing Mutect2 with {wildcards.sample}"
    threads: 1
    resources:
        mem_mb=1024,
    log:
        "logs/mutect_{sample}.log",
    wrapper:
        "v1.21.3/bio/gatk/mutect"
