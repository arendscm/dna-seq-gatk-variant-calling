rule gatk_filtermutectcalls:
    input:
        vcf="results/mutect/{sample}.vcf.gz",
        ref="resources/genome.fasta",
    output:
        vcf="results/filtered/{sample}.vcf.gz",
    log:
        "logs/gatk/filter/{sample}.log",
    params:
        extra="--max-alt-allele-count 3",  # optional arguments, see GATK docs
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v1.21.3/bio/gatk/filtermutectcalls"
       
rule bcftools_merge:
    input:
        calls=expand("results/mutect/{sample}.vcf.gz", sample=samples.index),
    output:
        "results/filtered/all.vcf.gz",
    log:
        "logs/bcf-merge.log"
    params:
        uncompressed_bcf=False,
        extra="",  # optional parameters for bcftools concat (except -o)
    wrapper:
        "v1.21.4/bio/bcftools/merge"   
