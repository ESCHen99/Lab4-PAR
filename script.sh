for i in {1..10}
do
	./$1 > /dev/null &
done
exit
