source var.sh
declare hdfs_input_dir="$1"
declare hdfs_output_dir="$2"

for((i=0; i<size_length; i++))
do
  for((j=0; j<count_length; j++))
  do
    spark-submit --class FileDetectorHdfs --master yarn --deploy-mode cluster --driver-memory 12g --executor-memory 12g --executor-cores 1 --queue default jars/spark-tika.jar ${hdfs_input_dir}/pdf_${sizes[i]}kb_${counts[j]}_files/ ${hdfs_output_dir} 
    sleep 5
  done
done