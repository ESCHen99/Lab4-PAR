for i in {1..10}
do
	echo $i
	./multisort-omp-tree-depend
done
exit
