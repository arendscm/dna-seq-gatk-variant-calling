rule annotate_variants:
    input:
        calls="results/filtered/{sample}.vcf.gz",
        cache="resources/vep/cache",
        plugins="resources/vep/plugins",
    output:
        calls=report(
            "results/annotated/{sample}.vcf.gz",
            caption="../report/{sample}.vcf.rst",
            category="Calls",
        ),
        stats=report(
            "results/stats/{sample}.stats.html",
            caption="../report/{sample}.stats.rst",
            category="Calls",
        ),
    params:
        # Pass a list of plugins to use, see https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html
        # Plugin args can be added as well, e.g. via an entry "MyPlugin,1,FOO", see docs.
        plugins=config["params"]["vep"]["plugins"],
        extra=config["params"]["vep"]["extra"],
    log:
        "logs/vep/{sample}.annotate.log",
    threads: 4
    wrapper:
        "0.74.0/bio/vep/annotate"
