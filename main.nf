#!/usr/bin/env nextflow
/*
========================================================================================
                         luslab/scrnaseq-gann
========================================================================================
----------------------------------------------------------------------------------------
*/

// Define DSL2
nextflow.preview.dsl=2

/* Module inclusions 
--------------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------------*/
/* Params
--------------------------------------------------------------------------------------*/

params.epochs = 1
params.writefreq = 1
params.datadir = ''

/*------------------------------------------------------------------------------------*/
/* Processes
--------------------------------------------------------------------------------------*/

process runGann {
  publishDir "${params.outdir}/gann",
    mode: "copy", overwrite: true

    input:
      path(datadir)

    output:
      path("*.*")

    shell:
      """
      python $baseDir/bin/arsh_attempt_2/main_train.py --train --epochs ${params.epochs} --write_freq ${params.writefreq} --output_dir . --data_dir ${params.data_dir}
      """
}

/*------------------------------------------------------------------------------------*/

// Run workflow
workflow {

  Channel
    .from(params.datadir)
    .set {ch_data}

    // run gann
    runGann(ch_data)
}