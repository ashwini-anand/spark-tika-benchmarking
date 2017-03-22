#local_input_dir must have pdf files pdf_100000.pdf , pdf_10000.pdf , pdf_1000.pdf , pdf_200.pdf , pdf_50000.pdf , pdf_500.pdf  available before running this script. Numeric value in name of files refers #to values of sizes array (declared in var.sh)

source var.sh
declare local_input_dir="$1"
declare hdfs_input_dir="$2"

(echo
echo "———————————————————————————————————————New Log Starts————————————————"
date
echo

for((i=0; i<size_length; i++))
do
  for((j=0; j<count_length; j++))
  do
    su - hdfs -c "hdfs dfs -mkdir -p ${hdfs_input_dir}/pdf_${sizes[i]}kb_${counts[j]}_files"
    su - hdfs -c "hdfs dfs -chown $USER ${hdfs_input_dir}/pdf_${sizes[i]}kb_${counts[j]}_files"
    time(for((k=0; k<${counts[$j]}; k++))
    do
      hdfs dfs -copyFromLocal ${local_input_dir}/pdf_${sizes[i]}.pdf ${hdfs_input_dir}/pdf_${sizes[i]}kb_${counts[j]}_files/pdf_${sizes[i]}kb_${counts[j]}_$k.pdf
    done
    echo ""
    echo transferred ${counts[j]} ${sizes[i]}kb files in below given time:)
  done
done) >> logs.txt 2>&1