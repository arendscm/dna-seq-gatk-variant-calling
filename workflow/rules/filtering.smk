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
