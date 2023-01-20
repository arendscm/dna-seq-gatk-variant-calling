rule gatk_filtermutectcalls:
    input:
        vcf="results/mutect/all.vcf.gz",
        ref="resources/genome.fasta",
    output:
        vcf="results/filtered/all.vcf.gz",
    log:
        "logs/gatk/filter/snvs.log",
    params:
        extra="--max-alt-allele-count 3",  # optional arguments, see GATK docs
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v1.21.3/bio/gatk/filtermutectcalls"
