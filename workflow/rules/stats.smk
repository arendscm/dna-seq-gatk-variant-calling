rule vcf_to_tsv:
    input:
        "results/annotated/{sample}.vcf.gz",
    output:
        report(
            "results/tables/{sample}.tsv.gz",
            caption="../report/{sample}.calls.rst",
            category="Calls",
        ),
    log:
        "logs/vcf-to-tsv.{sample}.log",
    conda:
        "../envs/rbt.yaml"
    shell:
        "(bcftools view --apply-filters PASS --output-type u {input} | "
        "rbt vcf-to-txt -g --fmt DP AD --info ANN | "
        "gzip > {output}) 2> {log}"
