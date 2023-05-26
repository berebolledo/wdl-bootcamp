version 1.0
workflow SamtoolsMetrics {
  input {
    File inputBam 
  }
  call Metrics {
    input: 
      bam_name = inputBam
  }
  output {
    File final_out = Metrics.metrics_out
  }
}

task Metrics {
  input {
    String bam_name    
  }
  command <<<
    samtools index ~{bam_name};
    samtools idxstats ~{bam_name} > counts.txt
  >>>
  output {
   File metrics_out = "counts.txt"
  }
  runtime {
    docker: 'bioinformage/wdl-bootcamp-practice:V1'
  }
}
